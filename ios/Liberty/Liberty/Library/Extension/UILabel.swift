//
//  UILabel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func setAttributedText(text: String, lineSpacing: CGFloat? = nil, letterSpacing: CGFloat? = nil) {
        let attributedString = NSMutableAttributedString(string: text)
        let textRange = NSRange(location: 0, length: attributedString.length)

        // Line spacing
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.alignment = textAlignment
            attributedString.addAttribute(
                NSAttributedString.Key.paragraphStyle,
                value: paragraphStyle,
                range: textRange
            )
        }

        // Letter spacing
        if let letterSpacing = letterSpacing {
            attributedString.addAttribute(
                NSAttributedString.Key.kern,
                value: letterSpacing,
                range: textRange
            )
        }

        self.attributedText = attributedString
    }

}
