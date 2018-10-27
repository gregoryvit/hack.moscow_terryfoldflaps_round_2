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

    @IBOutlet private weak var cameraViewPort: UIView!

    private let mobileNet = LibertyModel()
    private var visionRequests = [VNRequest]()

    private var cameraSession: AVCaptureSession?
    private var videoLayer: AVCaptureVideoPreviewLayer?

    private var shouldTakePhoto = false
    private var timer: Timer? = nil

    private var currentItemView: UIView?
    private var currentRateView: StarsRateView?
    private var currentRating: Double?
    private var isItemActive: Bool {
        return currentItemView != nil
    }

    var lastVector: [Double] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTimer()
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

    func configureModel() {
        guard let visionModel = try? VNCoreMLModel(for: mobileNet.model) else {
            print("Did not initialize the model from *.mlmodel")
            return
        }
        let rq = VNCoreMLRequest(model: visionModel, completionHandler: self.handleMlRequest)
        rq.imageCropAndScaleOption = .centerCrop
        visionRequests = [rq]
    }

    func configureProductView(book: Book) {
        clearCurrentPresentedView()
        let viewModel = ProductViewModel(with: book)
        let productView = ProductView()
        productView.configure(viewModel: viewModel)
        productView.delegate = self
        currentItemView = productView
        productView.alpha = 0.0
        view.addSubview(productView)
        UIView.animate(withDuration: 0.3) {
            productView.alpha = 1.0
        }
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        productView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func configurePersonView(person: Person) {
        clearCurrentPresentedView()
        let viewModel = PersonViewModel(with: person)
        let personView = PersonView()
        personView.configure(viewModel: viewModel)
        personView.delegate = self
        personView.alpha = 0.0
        currentItemView = personView
        view.addSubview(personView)
        UIView.animate(withDuration: 0.3) {
            personView.alpha = 1.0
        }
        personView.translatesAutoresizingMaskIntoConstraints = false
        personView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        personView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func configureRateView() -> StarsRateView {
        let rateView = StarsRateView()
        rateView.delegate = self
        rateView.configure(rating: currentRating)
        view.addSubview(rateView)
        let offset = UIScreen.main.bounds.width
        rateView.translatesAutoresizingMaskIntoConstraints = false
        rateView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -95).isActive = true
        rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset).isActive = true
        return rateView
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

        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
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
        currentRateView = configureRateView()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            let offset = UIScreen.main.bounds.width
            self.currentItemView?.transform = CGAffineTransform(translationX: -offset, y: 0.0)
            self.currentRateView?.transform = CGAffineTransform(translationX: -offset, y: 0.0)
        }
    }

    func retryButtonPressed() {
        clearCurrentPresentedView()
    }

    func didPressProduct() {
        print("product did pressed")
    }

    func didPressPerson() {
        print("person did pressed")
    }

}

extension CameraViewController: StarsRateViewDelegate {

    func didRateProduct(rating: Double?) {
        currentRating = rating != nil ? rating : currentRating
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            let offset = UIScreen.main.bounds.width
            self.currentItemView?.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            self.currentRateView?.transform = CGAffineTransform(translationX: offset, y: 0.0)
        }
    }

}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    @objc
    fileprivate func updateTimer() {
        self.shouldTakePhoto = !isItemActive
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

    func handleMlRequest(request: VNRequest, error: Error?) {        if let _ = error {
            return
        }
        guard let observations = request.results as? [VNCoreMLFeatureValueObservation],
            let vector = observations[0].featureValue.multiArrayValue
            else {
                return
        }
        lastVector = vector.arrayOfDoubles
        startSearchRequest(vector: lastVector)
    }

    func startSearchRequest(vector: [Double]) {
        VisualSearchEngine.searchCheck(of: vector)
        NetworkManager.search(vector: lastVector) { [weak self] (result) in
            guard let `self` = self else { return }
            if let book = result as? Book {
                self.configureProductView(book: book)
            } else if let person = result as? Person {
                self.configurePersonView(person: person)
            }
        }
    }

}

// MARK: - Help Methods

private extension CameraViewController {

    func clearCurrentPresentedView() {
        guard let currentView = currentItemView else { return }
        UIView.animate(withDuration: 0.3, animations: {
            currentView.alpha = 0.0
        }) { [weak self] (_) in
            currentView.removeFromSuperview()
            self?.currentItemView = nil
            self?.currentRating = nil
            self?.currentRateView = nil
        }
    }

    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(CameraViewController.updateTimer), userInfo: nil, repeats: true)
    }

}
