//
//  PersonCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var workButton: UIButton!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var websiteButton: UIButton!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Internal Methods

    func configure(with model: PersonDetailsViewModel) {
        avatarImageView.image = nil
        if let imageUrl = model.avatarUrl, let url = URL(string: imageUrl) {
            avatarImageView.af_setImage(withURL: url)
        }
        nameLabel.text = model.name
        workButton.setTitle(model.work, for: .normal)
        positionLabel.text = model.position
        descriptionLabel.setAttributedText(text: model.description, lineSpacing: 3, letterSpacing: nil)
        websiteButton.setTitle(model.website, for: .normal)
    }

}

// MARK: - Configure

private extension PersonCell {

    func setupInitialState() {
        configureAvatar()
        configreLabels()
    }

    func configureAvatar() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.layer.masksToBounds = true
    }

    func configreLabels() {
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        positionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

}
