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
    private var cellTypes: [DetailsTableCellType] = []

    // MARK: - Initialization

    init(for tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedCellHeight
        tableView.registerNib(SoldInStoresCell.self)
        self.tableView = tableView
    }

    // MARK: - Internal Methods

    func configure(with cellTypes: [DetailsTableCellType]) {
        self.cellTypes = cellTypes
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension DetailsAdapter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellTypes[indexPath.row]
        switch cellType {
        case .store(let stores, let title):
            return soldInStoresCell(for: tableView, indexPath: indexPath, stores: stores, title: title)
        case .social(let socials, let title):
            return soldInStoresCell(for: tableView, indexPath: indexPath, socials: socials, title: title)
        case .person(let person):
            return personCell(for: tableView, indexPath: indexPath, person: person)
        }
    }

}

// MARK: - UITableViewDelegate

extension DetailsAdapter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}

// MARK: - Private Methods

private extension DetailsAdapter {

    func soldInStoresCell(for tableView: UITableView, indexPath: IndexPath, stores: [StoreViewModel], title: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoldInStoresCell.nameOfClass, for: indexPath) as? SoldInStoresCell else {
            return UITableViewCell()
        }
        cell.configure(with: stores, title: title)
        return cell
    }

    func soldInStoresCell(for tableView: UITableView, indexPath: IndexPath, socials: [SocialViewModel], title: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoldInStoresCell.nameOfClass, for: indexPath) as? SoldInStoresCell else {
            return UITableViewCell()
        }
        cell.configure(with: socials, title: title)
        return cell
    }

    func personCell(for tableView: UITableView, indexPath: IndexPath, person: PersonViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.nameOfClass, for: indexPath) as? PersonCell else {
            return UITableViewCell()
        }
        cell.configure(with: person)
        return cell
    }

}
