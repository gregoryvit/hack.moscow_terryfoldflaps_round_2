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

    // MARK: - IBOutlets

    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var rateView: CosmosView!

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
        configureRateView()
    }

    func configureRateView() {
        rateView.rating = 0.0
        rateView.didFinishTouchingCosmos = { [weak self] rating in
            guard let `self` = self else { return }
            print(self.view.description)
        }
    }

}
