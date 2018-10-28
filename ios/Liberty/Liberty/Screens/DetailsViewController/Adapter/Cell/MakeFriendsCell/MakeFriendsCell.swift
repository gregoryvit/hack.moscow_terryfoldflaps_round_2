//
//  MakeFriendsCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class MakeFriendsCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var makeFriendsButton: UIButton!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Internal Methods

    func configure(with buttonTitle: String) {
        makeFriendsButton.setTitle(buttonTitle, for: .normal)
    }

}

// MARK: - Configure

private extension MakeFriendsCell {

    func setupInitialState() {
        makeFriendsButton.setRoundedStyleButton()
    }

}
