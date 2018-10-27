//
//  UIButton.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

// MARK: - Common Methods

extension UIButton {

    func setButtonImageForAllStates(image: UIImage) {
        setImage(image, for: .normal)
        setImage(image, for: .selected)
        setImage(image, for: .highlighted)
        setImage(image, for: .focused)
    }

    /// Method will set title press state color for all states
    func setTitlePressState(_ color: UIColor) {
        setTitleColor(color, for: .focused)
        setTitleColor(color, for: .selected)
        setTitleColor(color, for: .highlighted)
    }

}
