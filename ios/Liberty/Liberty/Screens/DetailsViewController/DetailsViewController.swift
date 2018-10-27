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
    }


}

// MARK: - Configure

private extension DetailsViewController {

    func setupInitialViewState() {
        configureContainer()
        configureAdapter()
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
