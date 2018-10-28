//
//  BookCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import Cosmos

final class BookCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var bookIconImageView: UIImageView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var bookTitle: UILabel!
    @IBOutlet private weak var bookAuthor: UILabel!
    @IBOutlet private weak var searchLocationTitle: UILabel!
    @IBOutlet private weak var priceTitle: UILabel!
    @IBOutlet private weak var bookDescriptionTitle: UILabel!
    @IBOutlet private weak var rateButton: UIButton!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }
    
}

// MARK: - Configure

private extension BookCell {

    func setupInitialState() {
        configureButtons()
        configureLabels()
    }

    func configureButtons() {
        rateButton.setTitle("ProductView.Buttons.title".localized(), for: .normal)
        rateButton.setTitleColor(ColorName.blueTheme, for: .normal)
        rateButton.setTitlePressState(ColorName.blueTheme.withAlphaComponent(0.6))
        rateButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }

    func configureLabels() {
        bookTitle.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        bookTitle.textColor = .black
        bookTitle.text = nil

        bookAuthor.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        bookAuthor.textColor = .black
        bookAuthor.text = nil

        searchLocationTitle.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        searchLocationTitle.textColor = .black
        searchLocationTitle.text = nil

        priceTitle.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        priceTitle.textColor = .black
        priceTitle.text = nil

        bookDescriptionTitle.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        bookDescriptionTitle.textColor = .black
        bookDescriptionTitle.text = nil
    }

}
