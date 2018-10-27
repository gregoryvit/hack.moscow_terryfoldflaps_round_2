//
//  ProductView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

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

    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productAuthorLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!

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

private extension ProductView {

    func setupInitialState() {
        configureContainerView()
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

}
