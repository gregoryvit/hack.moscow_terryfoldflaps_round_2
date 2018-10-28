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

    private enum DataType {
        case store
        case social
    }

    // MARK: - Constants

    private struct Constants {
        static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let cellSize: CGSize = CGSize(width: 94.0, height: 108.0)
        static let cellOffset: CGFloat = 10.0
    }

    // MARK: - Properties

    weak var delegate: SoldInStoresCellAdapterDelegate?

    // MARK: - Private Properties

    private let collectionView: UICollectionView
    private var currentType: DataType = .store
    private var stores: [StoreViewModel] = []
    private var socials: [SocialViewModel] = []

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

    // MARK: - Internal Methods

    func configure(with stores: [StoreViewModel]) {
        self.stores = stores
        currentType = .store
        collectionView.reloadData()
    }

    func configure(with socials: [SocialViewModel]) {
        self.socials = socials
        currentType = .social
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension SoldInStoresCellAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentType {
        case .store:
            return stores.count
        case .social:
            return socials.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentType {
        case .store:
            return storeCell(for: collectionView, indexPath: indexPath)
        case .social:
            return socialCell(for: collectionView, indexPath: indexPath)
        }
    }

}

// MARK: - UICollectionViewDelegate

extension SoldInStoresCellAdapter: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }

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

// MARK: - Private Methods

private extension SoldInStoresCellAdapter {

    func storeCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let storeCell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCollectionViewCell.identifier(), for: indexPath) as? StoreCollectionViewCell else {
            return UICollectionViewCell()
        }
        let store = stores[indexPath.row]
        storeCell.configure(with: store)
        return storeCell
    }

    func socialCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let socialCell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCollectionViewCell.identifier(), for: indexPath) as? StoreCollectionViewCell else {
            return UICollectionViewCell()
        }
        let social = socials[indexPath.row]
        socialCell.configure(with: social)
        return socialCell
    }

}
