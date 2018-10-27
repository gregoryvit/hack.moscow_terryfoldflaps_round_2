//
//  StarsRateView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import Cosmos

protocol StarsRateViewDelegate: class {
    func didRateProduct(rating: Double?)
}

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

    // MARK: - Properties

    weak var delegate: StarsRateViewDelegate?

    // MARK: - Private Properties

    private var didRate: Bool = false

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

    // MARK: - Configure

    func configure(rating: Double?) {
        rateView.rating = rating ?? 0.0
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
        rateView.didFinishTouchingCosmos = { [weak self] _ in
            guard let `self` = self else { return }
            self.didRate = true
        }
    }

}

// MARK: - Actions

private extension StarsRateView {

    @IBAction func backButtonPressed(_ sender: Any) {
        let rating = didRate ? rateView.rating : nil
        delegate?.didRateProduct(rating: rating)
    }

}
