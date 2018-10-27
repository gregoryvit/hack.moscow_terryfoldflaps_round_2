//
//  AppDelegate.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let mainTabBarView = MainTabBarViewController()
        if let currentWindow = UIApplication.shared.delegate?.window {
            currentWindow?.rootViewController = mainTabBarView
        }

        return true
    }

}
