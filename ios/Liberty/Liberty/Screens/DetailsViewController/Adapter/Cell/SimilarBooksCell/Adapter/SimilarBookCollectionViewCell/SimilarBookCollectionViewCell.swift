//
//  SimilarBookCollectionViewCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class SimilarBookCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var bookCoverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
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

    func configure(with model: SimilarBookViewModel) {
        if let imageUrl = model.coverImageUrl, let url = URL(string: imageUrl) {
            let placeholder = UIImage(named: "bookPlaceholder")
            bookCoverImageView.af_setImage(withURL: url, placeholderImage: placeholder)
        }
        nameLabel.setAttributedText(text: model.name, lineSpacing: 2, letterSpacing: nil)
        authorNameLabel.setAttributedText(text: model.authorName, lineSpacing: 2, letterSpacing: nil)
    }

}

// MARK: - Private Methods

private extension SimilarBookCollectionViewCell {

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
