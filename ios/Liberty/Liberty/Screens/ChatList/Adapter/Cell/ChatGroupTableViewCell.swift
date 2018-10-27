//
//  ChatGroupTableViewCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class ChatGroupTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var topicLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newMessagesContainer: UIView!
    @IBOutlet private weak var newMessagesLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = selected ? ColorName.pressState : UIColor.clear
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundColor = color
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = highlighted ? ColorName.pressState : UIColor.clear
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundColor = color
        }
    }

    // MARK: - Internal Methods

    func configure(with model: ChatGroupModel) {
        topicLabel.text = model.title
        descriptionLabel.text = model.description
        newMessagesLabel.text = model.newMessages > 9 ? "9+" : String(model.newMessages)
        newMessagesContainer.isHidden = model.newMessages <= 0
    }

}

// MARK: - Configure

private extension ChatGroupTableViewCell {

    func setupInitialState() {
        configureIcon()
        configureLabels()
        configureNewMessagesContainer()
    }

    func configureIcon() {
        iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.backgroundColor = ColorName.textExtra
    }

    func configureLabels() {
        topicLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        topicLabel.textColor = ColorName.text
        descriptionLabel.textColor = ColorName.text
    }

    func configureNewMessagesContainer() {
        newMessagesContainer.layer.cornerRadius = newMessagesContainer.bounds.width / 2
        newMessagesContainer.layer.masksToBounds = true
        newMessagesContainer.backgroundColor = ColorName.mainExtra

        newMessagesLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        newMessagesLabel.textColor = ColorName.text
    }

}
