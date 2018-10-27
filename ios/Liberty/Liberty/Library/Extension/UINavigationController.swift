//
//  UINavigationController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    func applyDarkBarStyle() {
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = ColorName.tabBarColor
        self.navigationBar.tintColor = ColorName.text
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorName.text,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: .semibold)]
        self.navigationBar.isTranslucent = false
        hideNavigationBarSeparator()
        self.navigationBar.dropShadow(color: ColorName.tabBarColor,
                                      opacity: 0.7,
                                      offSet: CGSize(width: 0, height: 0),
                                      radius: 4,
                                      scale: true)
    }

    func applyFakeTransparentBarStyle() {
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = ColorName.main
        self.navigationBar.tintColor = ColorName.text
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorName.text,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: .semibold)]
        self.navigationBar.isTranslucent = false
        hideNavigationBarSeparator()
        self.navigationBar.dropShadow(color: ColorName.tabBarColor,
                                      opacity: 0.0,
                                      offSet: CGSize(width: 0, height: 0),
                                      radius: 4,
                                      scale: true)
    }

    func hideNavigationBarSeparator() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }

    func showDefaultNavigationBarSeparator() {
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = nil
    }

}
