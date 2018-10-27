//
//  ProductView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import Cosmos

protocol ProductViewDelegate: class {
    func rateButtonPressed()
    func retryButtonPressed()
    func didPressProduct()
}

final class ProductView: DesignableView {

    // MARK: - Constants

    private struct Constants {
        static let containerCornerRadius: CGFloat = 6.0

        // Colors
        static let shadowColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        static let shadowOpacity: Float = 0.25
        static let shadowOffset: CGSize = CGSize(width: 0.0, height: 20.0)
        static let shadowRadius: CGFloat = 50.0
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productAuthorLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var rateButton: UIButton!
    @IBOutlet private weak var retryButton: UIButton!

    // MARK: - Properties

    weak var delegate: ProductViewDelegate?

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

    func configure(viewModel: ProductViewModel?) {
        productTitleLabel.text = viewModel?.productName
        productAuthorLabel.text = viewModel?.productAuthor
        productPriceLabel.text = viewModel?.productPrice
        productDescriptionLabel.text = viewModel?.productDescription
        ratingView.rating = Double(viewModel?.productRating ?? 0)
    }

}

// MARK: - Configure

private extension ProductView {

    func setupInitialState() {
        configureContainerView()
        configureLabels()
        configureButtons()
        configureTapGesture()
    }

    func configureContainerView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.layer.masksToBounds = true

        view.dropShadow(color: Constants.shadowColor,
                        opacity: Constants.shadowOpacity,
                        offSet: Constants.shadowOffset,
                        radius: Constants.shadowRadius,
                        scale: true)
    }

    func configureLabels() {
        productTitleLabel.textColor = .black
        productTitleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        productTitleLabel.text = nil

        productAuthorLabel.textColor = .black
        productAuthorLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        productAuthorLabel.text = nil

        productPriceLabel.textColor = .black
        productPriceLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        productPriceLabel.text = nil

        productDescriptionLabel.textColor = .black
        productDescriptionLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        productDescriptionLabel.text = nil
    }

    func configureButtons() {
        rateButton.setTitle("ProductView.Buttons.title".localized(), for: .normal)
        rateButton.setTitleColor(ColorName.blueTheme, for: .normal)
        rateButton.setTitlePressState(ColorName.blueTheme.withAlphaComponent(0.6))
        rateButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }

}

// MARK: - Actions

private extension ProductView {

    @IBAction func rateButtonDidPressed(_ sender: Any) {
        delegate?.rateButtonPressed()
    }

    @IBAction func retryButtonDidPressed(_ sender: Any) {
        delegate?.retryButtonPressed()
    }

    @objc
    func didTap() {
        delegate?.didPressProduct()
    }

}
