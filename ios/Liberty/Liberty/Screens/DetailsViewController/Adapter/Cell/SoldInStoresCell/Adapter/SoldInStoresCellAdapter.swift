//
//  SoldInStoresCellAdapter.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import UIKit

protocol SoldInStoresCellAdapterDelegate: class {

}

final class SoldInStoresCellAdapter: NSObject {

    // MARK: - Constants

    private struct Constants {
        static let estimatedCellHeight: CGFloat = 80
        static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let cellSize: CGSize = CGSize(width: 94.0, height: 108.0)
        static let cellOffset: CGFloat = 10.0
    }

    // MARK: - Properties

    weak var delegate: SoldInStoresCellAdapterDelegate?

    // MARK: - Private Properties

    private let collectionView: UICollectionView

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
        collectionView.registerNib(cellType: StoreCollectionViewCell.self)
        collectionView.clipsToBounds = false
        self.collectionView = collectionView
    }

}

// MARK: - UICollectionViewDataSource

extension SoldInStoresCellAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let storeCell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCollectionViewCell.identifier(), for: indexPath) as? StoreCollectionViewCell else {
            return UICollectionViewCell()
        }
        return storeCell
    }

}

// MARK: - UICollectionViewDelegate

extension SoldInStoresCellAdapter: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout

extension SoldInStoresCellAdapter: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellOffset
    }

}
