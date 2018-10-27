//
//  DetailsAdapter.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsAdapterDelegate: class {

}

final class DetailsAdapter: NSObject {

    // MARK: - Constants

    private struct Constants {
        static let estimatedCellHeight: CGFloat = 80
    }

    // MARK: - Properties

    weak var delegate: DetailsAdapterDelegate?

    // MARK: - Private Properties

    private let tableView: UITableView

    // MARK: - Initialization

    init(for tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedCellHeight
        tableView.registerNib(SoldInStoresCell.self)
        self.tableView = tableView
    }

}

// MARK: - UITableViewDataSource

extension DetailsAdapter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return soldInStoresCell(for: tableView, indexPath: indexPath)
    }

}

// MARK: - UITableViewDelegate

extension DetailsAdapter: UITableViewDelegate {

}

// MARK: - Private Methods

private extension DetailsAdapter {

    func soldInStoresCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoldInStoresCell.nameOfClass, for: indexPath) as? SoldInStoresCell else {
            return UITableViewCell()
        }
        return cell
    }

}
