//
//  SoldInStoresCell.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import CoreLocation

final class SoldInStoresCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Private Properties

    private var adapter: SoldInStoresCellAdapter?

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        scetupInitialState()
        // TODO: test code
        adapter?.configure(with: generateTestStores())
    }

    // MARK: - Internal Methods

    func configure() {
        
    }

}

// MARK: - Configure

private extension SoldInStoresCell {

    func scetupInitialState() {
        configureTitleLabel()
        configureAdapter()
    }

    func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor.black
    }

    func configureAdapter() {
        adapter = SoldInStoresCellAdapter(for: collectionView)
        adapter?.delegate = self
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
    }

}

// MARK: - SoldInStoresCellAdapterDelegate

extension SoldInStoresCell: SoldInStoresCellAdapterDelegate {

}

// MARK: - Private Methods

private extension SoldInStoresCell {

    func generateTestStores() -> [StoreViewModel] {
        let model1 = StoreViewModel(id: "1", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fbb/NpM3VBu1nL4.jpg", price: "2 465 ₽", position: nil, deliveryAvailable: true)
        let model2 = StoreViewModel(id: "2", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fc2/MbRM76AF4mE.jpg", price: "2 765 ₽", position: CLLocationCoordinate2D(latitude: 0, longitude: 0), deliveryAvailable: true)
        let model3 = StoreViewModel(id: "3", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fc9/iipk0jdZX0M.jpg", price: "2 832 ₽", position: CLLocationCoordinate2D(latitude: 0, longitude: 0), deliveryAvailable: true)
        return [model1, model2, model3]
    }
}
