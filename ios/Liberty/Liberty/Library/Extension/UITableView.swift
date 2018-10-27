//
//  UITableView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

public extension UITableView {

    func registerNib(_ cellType: UITableViewCell.Type) {
        register(UINib(nibName: cellType.nameOfClass, bundle: nil), forCellReuseIdentifier: cellType.nameOfClass)
    }

}

public extension UITableViewCell {

    class func identifier() -> String {
        return self.nameOfClass
    }

}
