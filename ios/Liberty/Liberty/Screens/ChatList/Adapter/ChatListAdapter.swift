//
//  ChatListAdapter.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit

protocol ChatListAdapterDelegate: class {
    func showSectionTitle(_ title: String?)
}

final class ChatListAdapter: NSObject {

    // MARK: - Constants

    private struct Constants {
        static let estimatedCellHeight: CGFloat = 80
    }

    // MARK: - Properties

    weak var delegate: ChatListAdapterDelegate?

    // MARK: - Private Properties

    private let tableView: UITableView
    private var sectionsModels: [ChatListSectionModel] = []
    private var hiddenSectionsTitles: [String] = []

    // MARK: - Initialization

    init(for tableView: UITableView) {
        tableView.backgroundColor = ColorName.main
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedCellHeight
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        tableView.registerNib(ChatGroupTableViewCell.self)
        tableView.registerNib(ChatListHeaderCell.self)
        self.tableView = tableView
    }

    // MARK: - Internal Methods

    func configure(with sections: [ChatListSectionModel]) {
        self.sectionsModels = sections
        hiddenSectionsTitles = []
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension ChatListAdapter: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsModels.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsModels[section].models.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            cell = headerCell(for: tableView, indexPath: indexPath)
        } else {
            cell = chatGroupCell(for: tableView, indexPath: indexPath)
        }
        return cell
    }

}

// MARK: - UITableViewDelegate

extension ChatListAdapter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let sectionName = sectionsModels[indexPath.section].sectionName
            if let index = hiddenSectionsTitles.lastIndex(of: sectionName) {
                hiddenSectionsTitles.remove(at: index)
                delegate?.showSectionTitle(hiddenSectionsTitles.last)
            }
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            hiddenSectionsTitles.append(sectionsModels[indexPath.section].sectionName)
            delegate?.showSectionTitle(hiddenSectionsTitles.last)
        }
    }

}

// MARK: - Private Methods

private extension ChatListAdapter {

    func headerCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListHeaderCell.nameOfClass, for: indexPath) as? ChatListHeaderCell else {
            return UITableViewCell()
        }
        let section = sectionsModels[indexPath.section]
        cell.configure(with: section.sectionName)
        return cell
    }

    func chatGroupCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatGroupTableViewCell.nameOfClass, for: indexPath) as? ChatGroupTableViewCell else {
            return UITableViewCell()
        }
        let models = sectionsModels[indexPath.section].models
        cell.configure(with: models[indexPath.row - 1])
        return cell
    }

}
