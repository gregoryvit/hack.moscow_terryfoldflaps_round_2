//
//  Preloadable.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

/// Inherit custom subview from this class instead of UIView,
///     mark it as @IBDesignable,
///     set the file's owner and do not set the View's class,
///     =>
///     It renders in the IB!
class DesignableView: UIView {

    var view: UIView! {
        return subviews.first
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // TODO: check it
        _ = setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = setup()
    }

    func setup() -> UIView? {
        let view = Bundle(for: type(of: self)).loadNibNamed(self.nameOfClass, owner: self, options: nil)?.first as? UIView
        if let v = view {
            addSubview(v)
            v.frame = self.bounds
        }
        return view
    }
}
