//
//  CameraViewController.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

final class CameraViewController: UIViewController {

    @IBOutlet fileprivate weak var cameraViewPort: UIView!

    fileprivate let mobileNet = LibertyModel()
    fileprivate var visionRequests = [VNRequest]()

    fileprivate var cameraSession: AVCaptureSession?
    fileprivate var videoLayer: AVCaptureVideoPreviewLayer?

    fileprivate var shouldTakePhoto = false
    fileprivate var timer: Timer? = nil

    var lastVector: [Double] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        configureProductView()
//        configurePersonView()
        configureRateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(CameraViewController.updateTimer), userInfo: nil, repeats: true)

        setupCamera()
        configureModel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        timer?.invalidate()
        timer = nil
        cameraSession?.stopRunning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func printVector(_ sender: Any) {
        print("===========================")
        print(lastVector)
    }

    func configureModel() {
        guard let visionModel = try? VNCoreMLModel(for: mobileNet.model) else {
            print("Did not initialize the model from *.mlmodel")
            return
        }
        let rq = VNCoreMLRequest(model: visionModel, completionHandler: self.handleMlRequest)
        rq.imageCropAndScaleOption = .centerCrop
        visionRequests = [rq]
    }

    func configureProductView() {
        let viewModel = ProductViewModel(productName: "Санина индахаус продакшен представляет для вас наш проект", productAuthor: "Влад Крупенько", productPrice: "2 465 ₽", productDescription: "средняя цена", productRating: 4)
        let productView = ProductView()
        productView.configure(viewModel: viewModel)
        productView.delegate = self
        view.addSubview(productView)
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        productView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func configurePersonView() {
        let viewModel = PersonViewModel(personName: "Grigory Berngardt", personPosition: "iOS Lead", personIconUrl: "https://pp.userapi.com/c638619/v638619546/510ff/dzyIBJ927_s.jpg")
        let personView = PersonView()
        personView.configure(viewModel: viewModel)
        personView.delegate = self
        view.addSubview(personView)
        personView.translatesAutoresizingMaskIntoConstraints = false
        personView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        personView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func configureRateView() {
        let rateView = StarsRateView()
        view.addSubview(rateView)
        rateView.translatesAutoresizingMaskIntoConstraints = false
        rateView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func setupCamera() {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo

        guard let backCamera = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: backCamera)
            else {
                return
        }
        session.addInput(input)

        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.videoSettings = [ kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA) ]
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "cameraOutput"))
        session.addOutput(output)

        let connection = output.connection(with: .video)
        connection?.videoOrientation = .portrait

        session.startRunning()

        self.cameraSession = session

        DispatchQueue.main.async { [unowned self] in
            let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.frame = self.cameraViewPort.layer.bounds
            self.cameraViewPort.layer.addSublayer(videoPreviewLayer)

            self.videoLayer = videoPreviewLayer
        }
    }
}

extension CameraViewController: ProductViewDelegate, PersonViewDelegate {

    func rateButtonPressed() {
        print("rate button pressed")
    }

    func retryButtonPressed() {
        print("retry button pressed")
    }

}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    @objc
    fileprivate func updateTimer() {
        self.shouldTakePhoto = true
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        guard shouldTakePhoto else {
            return
        }
        shouldTakePhoto = false

        DispatchQueue.main.async { [unowned self] in

            guard let image = UIImage(from: sampleBuffer) else {
                return
            }

            var requestOptions: [VNImageOption: Any] = [:]

            if let cameraIntrinsicData = CMGetAttachment(sampleBuffer,
                                                         key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix,
                                                         attachmentModeOut: nil) {
                requestOptions = [.cameraIntrinsics: cameraIntrinsicData]
            }

            let fraction = (self.cameraViewPort.frame.width - 32) / self.cameraViewPort.frame.width
            let size = CGSize(width: image.size.width * fraction,
                              height: image.size.width * fraction)

            let crop = image.centerCrop(size: size)

            guard let cgCrop = crop?.resize(toSize: CGSize(width: 224, height: 224)).cgImage else {
                return
            }

            let imageRequestHandler = VNImageRequestHandler(cgImage: cgCrop, orientation: .up, options: requestOptions)
            do {
                try imageRequestHandler.perform(self.visionRequests)
            } catch {
                print(error)
            }
        }
    }

    func handleMlRequest(request: VNRequest, error: Error?) {
        if let _ = error {
            return
        }
        guard let observations = request.results as? [VNCoreMLFeatureValueObservation],
            let vector = observations[0].featureValue.multiArrayValue
            else {
                return
        }
        lastVector = vector.arrayOfDoubles
        VisualSearchEngine.searchCheck(of: lastVector)
    }
}
