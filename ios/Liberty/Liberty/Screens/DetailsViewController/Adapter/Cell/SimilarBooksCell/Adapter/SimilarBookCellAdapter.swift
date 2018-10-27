//
//  SimilarBookCellAdapter.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit

protocol SimilarBookCellAdapterDelegate: class {
}

final class SimilarBookCellAdapter: NSObject {

    // MARK: - Constants

    private struct Constants {
        static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let cellSize: CGSize = CGSize(width: 137.0, height: 204.0)
        static let cellOffset: CGFloat = 10.0
    }

    // MARK: - Properties

    weak var delegate: SimilarBookCellAdapterDelegate?

    // MARK: - Private Properties

    private let collectionView: UICollectionView
    private var books: [SimilarBookViewModel] = []

    // MARK: - Initialization

    init(for collectionView: UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = Constants.sectionInset
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        collectionView.registerNib(cellType: SimilarBookCollectionViewCell.self)
        collectionView.clipsToBounds = false
        self.collectionView = collectionView
    }

    // MARK: - Internal Methods

    func configure(with books: [SimilarBookViewModel]) {
        self.books = books
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension SimilarBookCellAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarBookCollectionViewCell.identifier(), for: indexPath) as? SimilarBookCollectionViewCell else {
            return UICollectionViewCell()
        }
        bookCell.configure(with: books[indexPath.row])
        return bookCell
    }

}

// MARK: - UICollectionViewDelegate

extension SimilarBookCellAdapter: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension SimilarBookCellAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellOffset
    }

}
