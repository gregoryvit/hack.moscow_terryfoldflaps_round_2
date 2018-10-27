//
//  LibertyLoader.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

final class LibertyLoader: DesignableView {

    // MARK: - Private Properties

    private var activityIndicator: NVActivityIndicatorView?
    private var shadow: CAShapeLayer?

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if shadow == nil {
            let shadowLayer = CAShapeLayer()

            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize.zero
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 6

            shadow = shadowLayer
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

    // MARK: - Internal Methods

    func startLoading() {
        self.isHidden = false
        activityIndicator?.startAnimating()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 1
        }
    }

    func stopLoading() {
        activityIndicator?.stopAnimating()
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] (_) in
            self?.isHidden = true
        }
    }

}

// MARK: - Configure

private extension LibertyLoader {

    func setupInitialState() {
        configureBackground()
        configureActivityIndicator()
        alpha = 0
        isHidden = true
    }

    func configureBackground() {
        view.layer.cornerRadius = bounds.width / 2
        view.layer.masksToBounds = true
    }

    func configureActivityIndicator() {
        let indicator = NVActivityIndicatorView(frame: self.bounds,
                                                type: .circleStrokeSpin,
                                                color: ColorName.loaderColor,
                                                padding: 5)
        self.view.addSubview(indicator)
        activityIndicator = indicator
    }

}
