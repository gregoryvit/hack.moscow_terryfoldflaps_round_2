//
//  DetailsViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import CoreLocation

class DetailsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var closeButtonContainer: UIView!
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    var onDismiss: (() -> Void)?

    // MARK: - Private Properties

    private var adapter: DetailsAdapter?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViewState()
        let zeroCell: DetailsTableCellType = .person(generateTestPerson())
        let firstCell: DetailsTableCellType = .store(generateTestStores(), "Продается в магазинах")
        let secondCell: DetailsTableCellType = .social(generateTestSocials(), "Социальные сети")
        adapter?.configure(with: [zeroCell, firstCell, secondCell])
    }

}

// MARK: - Configure

private extension DetailsViewController {

    func setupInitialViewState() {
        configureContainer()
        configureAdapter()
        configureBlurEffect()
    }

    func configureContainer() {
        container.layer.cornerRadius = 6
        container.layer.masksToBounds = true
    }

    func configureAdapter() {
        adapter = DetailsAdapter(for: tableView)
        adapter?.delegate = self
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }

    func configureBlurEffect() {
        closeButtonContainer.backgroundColor = UIColor.clear

        let blurEffect = UIBlurEffect(style: .light)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)

        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = closeButtonContainer.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.frame = closeButtonContainer.bounds
        vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        closeButtonContainer.insertSubview(blurEffectView, at: 0)
        blurEffectView.contentView.addSubview(vibrancyView)

        closeButtonContainer.layer.cornerRadius = closeButtonContainer.bounds.width / 2
        closeButtonContainer.layer.masksToBounds = true
    }

}

// MARK: - Actions

private extension DetailsViewController {

    @IBAction func tapOnCloseButton(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - DetailsAdapterDelegate

extension DetailsViewController: DetailsAdapterDelegate {

}

// MARK: - Private Methods

private extension DetailsViewController {

    func generateTestStores() -> [StoreViewModel] {
        let model1 = StoreViewModel(id: "1", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fbb/NpM3VBu1nL4.jpg", price: "2 465 ₽", position: nil, deliveryAvailable: true)
        let model2 = StoreViewModel(id: "2", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fc2/MbRM76AF4mE.jpg", price: "2 765 ₽", position: CLLocationCoordinate2D(latitude: 0, longitude: 0), deliveryAvailable: true)
        let model3 = StoreViewModel(id: "3", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fc9/iipk0jdZX0M.jpg", price: "2 832 ₽", position: CLLocationCoordinate2D(latitude: 0, longitude: 0), deliveryAvailable: true)
        return [model1, model2, model3]
    }

    func generateTestSocials() -> [SocialViewModel] {
        let model1 = SocialViewModel(name: "Twitter", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b54/TnEfxqSiPhs.jpg")
        let model2 = SocialViewModel(name: "Instagram", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b46/gRJwvj69hMM.jpg")
        let model3 = SocialViewModel(name: "Facebook", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b4d/qxyrgyBoUag.jpg")
        let model4 = SocialViewModel(name: "Vk", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b5b/xtCAzOXxMEg.jpg")
        return [model1, model2, model3, model4]
    }

    func generateTestPerson() -> PersonDetailsViewModel {
        return PersonDetailsViewModel(avatarUrl: nil, name: "Григорий Бернгардт", work: "Surf Studio", position: "iOS Lead", description: "Занимаюсь iOS разработкой последние 6 лет. За это время поработал с большим кол-вом проектов в разного рода компаниях, стартапах, фрилансе и крупных аутсорсинговых компаниях. Сейчас возглавляю отдел iOS разработки в небольшой, но классной студии Surf.", website: "berngardt.ru")
    }

}
