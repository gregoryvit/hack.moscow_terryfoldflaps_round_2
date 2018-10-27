//
//  MainTabBarViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // MARK: - Constants

    private struct Constants {
        static let imageTopOffset: CGFloat = 5
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - Private Methods

private extension MainTabBarViewController {

    func setupInitialState() {
        configureControllers()
        configureShadow()
        removeTopSeparator()
    }

    func configureControllers() {
        let mainView = MainViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainView)
        let mainTabBarIcon = UIImage(named: "tabBarMain")
        let mainBarItem = UITabBarItem(title: nil,
                                       image: mainTabBarIcon?.withRenderingMode(.alwaysTemplate),
                                       tag: 0)
        mainNavigationController.tabBarItem = mainBarItem

        let chatListView = ChatListViewController()
        let chatListNavigationController = UINavigationController(rootViewController: chatListView)
        let chatListTabBarIcon = UIImage(named: "tabBarChat")
        let chatListBarItem = UITabBarItem(title: nil,
                                           image: chatListTabBarIcon?.withRenderingMode(.alwaysTemplate),
                                           tag: 1)
        chatListNavigationController.tabBarItem = chatListBarItem

        let profileView = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileView)
        let profileTabBarIcon = UIImage(named: "tabBarProfile")
        let profileBarItem = UITabBarItem(title: nil,
                                          image: profileTabBarIcon?.withRenderingMode(.alwaysTemplate),
                                          tag: 1)
        profileNavigationController.tabBarItem = profileBarItem

        self.tabBar.barTintColor = ColorName.tabBarColor
        self.tabBar.tintColor = ColorName.mainExtra
        self.tabBar.unselectedItemTintColor = ColorName.textExtra
        self.tabBar.isTranslucent = false

        for item in [mainBarItem, chatListBarItem, profileBarItem] {
            item.imageInsets = UIEdgeInsets(top: Constants.imageTopOffset, left: 0, bottom: -Constants.imageTopOffset, right: 0)
        }

        self.viewControllers = [mainNavigationController, chatListNavigationController, profileNavigationController]
    }

    func configureShadow() {
        self.tabBar.dropShadow(color: ColorName.tabBarColor,
                               opacity: 0.7,
                               offSet: CGSize(width: 0, height: 0),
                               radius: 4,
                               scale: true)
    }

    func removeTopSeparator() {
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }

}
