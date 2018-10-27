//
//  ChatListViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ChatListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorContainer: UIView!

    // MARK: - Private Properties

    private var adapter: ChatListAdapter?
    private var activityIndicator: NVActivityIndicatorView?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadChatGroups()
    }
}

// MARK: - Configure

private extension ChatListViewController {

    func setupInitialState() {
        view.backgroundColor = ColorName.main
        navigationController?.applyFakeTransparentBarStyle()
        configureAdapter()
        configureActivityIndicator()
    }

    func configureAdapter() {
        adapter = ChatListAdapter(for: tableView)
        adapter?.delegate = self
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }

    func configureActivityIndicator() {
        let activityIndicator = NVActivityIndicatorView(frame: activityIndicatorContainer.bounds,
                                                        type: NVActivityIndicatorType.audioEqualizer,
                                                        color: ColorName.text,
                                                        padding: nil)
        activityIndicatorContainer.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
    }

}

// MARK: - ChatListAdapterDelegate

extension ChatListViewController: ChatListAdapterDelegate {

    func showSectionTitle(_ title: String?) {
        if let title = title {
            navigationController?.applyDarkBarStyle()
            navigationItem.title = title
        } else {
            navigationController?.applyFakeTransparentBarStyle()
            navigationItem.title = nil
        }
    }

}

// MARK: - NetworkFlow

private extension ChatListViewController {

    func loadChatGroups() {
        showLoader()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.0) { [weak self] in
            guard let `self` = self else { return }
            self.adapter?.configure(with: self.generateTestData())
            self.showTableView()
        }
    }

}

// MARK: - Private Methods

private extension ChatListViewController {

    func showLoader() {
        activityIndicatorContainer.isHidden = false
        activityIndicator?.startAnimating()
        tableView.isHidden = true
    }

    func showTableView() {
        activityIndicatorContainer.isHidden = true
        activityIndicator?.stopAnimating()
        tableView.isHidden = false
    }

    func generateTestData() -> [ChatListSectionModel] {
        let group1 = ChatGroupModel(avatarUrl: nil, title: "Дизайн", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let group2 = ChatGroupModel(avatarUrl: nil, title: "Живопись", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let group3 = ChatGroupModel(avatarUrl: nil, title: "Музыка", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let section1 = ChatListSectionModel(with: "Искусство", models: [group1, group2, group3])

        let group7 = ChatGroupModel(avatarUrl: nil, title: "Дизайн", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let group4 = ChatGroupModel(avatarUrl: nil, title: "Живопись", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let group5 = ChatGroupModel(avatarUrl: nil, title: "Музыка", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let group6 = ChatGroupModel(avatarUrl: nil, title: "Литература", description: "Qwe sfasd asdfsdf asdfasdf asdf", newMessages: 0)
        let section2 = ChatListSectionModel(with: "Поп культура", models: [group7, group4, group5, group6])

        return [section1, section2]
    }

}
