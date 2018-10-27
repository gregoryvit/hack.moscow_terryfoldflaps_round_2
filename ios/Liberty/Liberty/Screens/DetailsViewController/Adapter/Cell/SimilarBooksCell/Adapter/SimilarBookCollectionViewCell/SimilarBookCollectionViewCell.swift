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

    // MARK: - Internal Methods

    func configure(with model: SimilarBookViewModel) {
        if let imageUrl = model.coverImageUrl, let url = URL(string: imageUrl) {
            let placeholder = UIImage(named: "bookPlaceholder")
            bookCoverImageView.af_setImage(withURL: url, placeholderImage: placeholder)
        }
        nameLabel.setAttributedText(text: model.name, lineSpacing: 3, letterSpacing: nil)
        authorNameLabel.setAttributedText(text: model.authorName, lineSpacing: 2, letterSpacing: nil)
    }

}
