//
//  UICollectionView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func registerNib(cellType: UICollectionViewCell.Type) {
        register(UINib(nibName: cellType.nameOfClass, bundle: nil), forCellWithReuseIdentifier: cellType.nameOfClass)
    }

}

public extension UICollectionViewCell {

    class func identifier() -> String {
        return self.nameOfClass
    }

}
