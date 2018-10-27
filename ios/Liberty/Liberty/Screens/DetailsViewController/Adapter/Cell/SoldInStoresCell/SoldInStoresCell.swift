//
//  SoldInStoresCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class SoldInStoresCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        scetupInitialState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Configure

private extension SoldInStoresCell {

    func scetupInitialState() {
        configureTitleLabel()
        configureAdapter()
    }

    func configureTitleLabel() {

    }

    func configureAdapter() {

    }

}
