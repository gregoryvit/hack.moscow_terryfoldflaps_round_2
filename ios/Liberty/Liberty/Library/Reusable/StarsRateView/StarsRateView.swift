//
//  StarsRateView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import Cosmos

final class StarsRateView: DesignableView {

    // MARK: - Constants

    private struct Constants {
        // Colors
        static let shadowColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        static let shadowOpacity: Float = 0.25
        static let shadowOffset: CGSize = CGSize(width: 0.0, height: 20.0)
        static let shadowRadius: CGFloat = 50.0
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var rateView: CosmosView!
    @IBOutlet private weak var rateViewContainer: UIView!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

// MARK: - Configure

private extension StarsRateView {

    func setupInitialState() {
        configureContainerView()
        configureRateView()
    }

    func configureContainerView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = rateViewContainer.frame.height / 2
        view.layer.masksToBounds = true
        rateViewContainer.backgroundColor = .clear

        view.dropShadow(color: Constants.shadowColor,
                        opacity: Constants.shadowOpacity,
                        offSet: Constants.shadowOffset,
                        radius: Constants.shadowRadius,
                        scale: true)
    }

    func configureRateView() {
        rateView.rating = 0.0
    }

}
