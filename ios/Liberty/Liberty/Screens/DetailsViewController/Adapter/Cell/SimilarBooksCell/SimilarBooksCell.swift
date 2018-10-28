//
//  SimilarBooksCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class SimilarBooksCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Private Properties

    private var adapter: SimilarBookCellAdapter?

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Internal Methods

    func configure(with books: [SimilarBookViewModel], title: String) {
        adapter?.configure(with: books)
        titleLabel.text = title
    }

}

// MARK: - Configure

private extension SimilarBooksCell {

    func setupInitialState() {
        configureTitleLabel()
        configureAdapter()
    }

    func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor.black
    }

    func configureAdapter() {
        adapter = SimilarBookCellAdapter(for: collectionView)
        adapter?.delegate = self
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
    }

}

extension SimilarBooksCell: SimilarBookCellAdapterDelegate {
}
