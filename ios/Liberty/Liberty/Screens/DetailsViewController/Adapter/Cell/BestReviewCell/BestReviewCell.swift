//
//  BestReviewCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class BestReviewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var allReviewsButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var goodReviewButton: UIButton!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Internal Methods

    func configure(with model: ReviewViewModel) {
        avatarImageView.image = nil
        if let imageUrl = model.authorAvatar, let url = URL(string: imageUrl) {
            avatarImageView.af_setImage(withURL: url)
        }
        nameLabel.text = model.authorName
        sourceLabel.text = model.reviewSource
        descriptionLabel.setAttributedText(text: model.reviewText, lineSpacing: 3, letterSpacing: nil)
    }

}

// MARK: - Configure

private extension BestReviewCell {

    func setupInitialState() {
        configureAvatarImageView()
        configureLocalizedStrings()

        goodReviewButton.setRoundedStyleButton()
    }

    func configureAvatarImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.masksToBounds = true
    }

    func configureLocalizedStrings() {
        titleLabel.text = "Лучший отзыв".localized()
        allReviewsButton.setTitle("Все отзывы".localized(), for: .normal)
        goodReviewButton.setTitle("Полезный отзыв".localized(), for: .normal)
    }

}
