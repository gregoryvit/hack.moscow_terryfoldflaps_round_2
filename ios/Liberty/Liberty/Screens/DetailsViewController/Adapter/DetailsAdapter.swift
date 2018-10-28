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
        tableView.registerNib(PersonCell.self)
        tableView.registerNib(MakeFriendsCell.self)
        tableView.registerNib(BestReviewCell.self)
        tableView.registerNib(SimilarBooksCell.self)
        tableView.registerNib(BookCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 21, right: 0)
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
        case .makeFriends:
            return makeFriendsCell(for: tableView, indexPath: indexPath)
        case .bestReview(let review):
            return bestReviewCell(for: tableView, indexPath: indexPath, review: review)
        case .similarBooks(let books, let title):
            return similarBooksCell(for: tableView, indexPath: indexPath, books: books, title: title)
        case .changeProfile:
            return changeProfileCell(for: tableView, indexPath: indexPath)
        case .book(let book):
            return bookCell(for: tableView, indexPath: indexPath, book: book)
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

    func personCell(for tableView: UITableView, indexPath: IndexPath, person: PersonDetailsViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.nameOfClass, for: indexPath) as? PersonCell else {
            return UITableViewCell()
        }
        cell.configure(with: person)
        return cell
    }

    func makeFriendsCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MakeFriendsCell.nameOfClass, for: indexPath) as? MakeFriendsCell else {
            return UITableViewCell()
        }
        cell.configure(with: "Подружиться во всех соцсетях".localized())
        return cell
    }

    func bestReviewCell(for tableView: UITableView, indexPath: IndexPath, review: ReviewViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BestReviewCell.nameOfClass, for: indexPath) as? BestReviewCell else {
            return UITableViewCell()
        }
        cell.configure(with: review)
        return cell
    }

    func similarBooksCell(for tableView: UITableView, indexPath: IndexPath, books: [SimilarBookViewModel], title: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarBooksCell.nameOfClass, for: indexPath) as? SimilarBooksCell else {
            return UITableViewCell()
        }
        cell.configure(with: books, title: title)
        return cell
    }

    func changeProfileCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MakeFriendsCell.nameOfClass, for: indexPath) as? MakeFriendsCell else {
            return UITableViewCell()
        }
        cell.configure(with: "Изменить профиль".localized())
        return cell
    }

    func bookCell(for tableView: UITableView, indexPath: IndexPath, book: ProductViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.nameOfClass, for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: book)
        return cell
    }

}
