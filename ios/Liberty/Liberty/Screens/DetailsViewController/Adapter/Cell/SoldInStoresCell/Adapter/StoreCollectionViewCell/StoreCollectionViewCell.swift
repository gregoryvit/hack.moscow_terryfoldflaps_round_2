//
//  StoreCollectionViewCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private struct Constants {
        static let defaultArraoImageWidth: CGFloat = 15
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var arrowImageWidthConstraint: NSLayoutConstraint!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

}

// MARK: - Configure

private extension StoreCollectionViewCell {

    func setupInitialState() {
        configureBorder()
        configureLabels()
    }

    func configureBorder() {
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = ColorName.grayBorder.cgColor
        contentView.layer.borderWidth = 1
    }

    func configureLabels() {
        priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }

}
