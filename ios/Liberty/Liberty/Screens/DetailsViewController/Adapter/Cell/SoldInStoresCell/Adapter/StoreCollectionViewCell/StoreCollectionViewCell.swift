//
//  StoreCollectionViewCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import CoreLocation
import AlamofireImage

final class StoreCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private struct Constants {
        static let defaultArraoImageWidth: CGFloat = 15
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var highlightedView: UIView!

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var arrowImageWidthConstraint: NSLayoutConstraint!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                makeSelected()
            } else {
                makeDeselected()
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                makeSelected()
            } else {
                makeDeselected()
            }
        }
    }

    // MARK: - Internal Methods

    func configure(with model: StoreViewModel) {
        priceLabel.text = model.price
        iconImageView.contentMode = .scaleAspectFit
        if let _ = model.position {
            let randomDistance = Double(arc4random() % 100) / 10.0
            descriptionLabel.text = String(randomDistance) + " km".localized()
            arrowImageWidthConstraint.constant = Constants.defaultArraoImageWidth
        } else {
            descriptionLabel.text = model.deliveryAvailable ? "delivery".localized() : ""
            arrowImageWidthConstraint.constant = 0
        }
        iconImageView.image = nil
        if let imageUrl = model.iconUrl, let url = URL(string: imageUrl) {
            iconImageView.af_setImage(withURL: url)
        }
    }

    func configure(with socialModel: SocialViewModel) {
        iconImageView.contentMode = .center
        priceLabel.text = socialModel.name
        descriptionLabel.text = ""
        arrowImageWidthConstraint.constant = 0
        iconImageView.image = nil
        if let imageUrl = socialModel.iconUrl, let url = URL(string: imageUrl) {
            iconImageView.af_setImage(withURL: url)
        }
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

    func makeSelected() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    func makeDeselected() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.contentView.transform = .identity
        }
    }

}
