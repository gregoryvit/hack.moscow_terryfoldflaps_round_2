//
//  DetailsViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

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
    private var cells: [DetailsTableCellType] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialViewState()
        adapter?.configure(with: cells)
    }

    // MARK: - Internal Methods

    func configure(with cells: [DetailsTableCellType]) {
        self.cells = cells
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
