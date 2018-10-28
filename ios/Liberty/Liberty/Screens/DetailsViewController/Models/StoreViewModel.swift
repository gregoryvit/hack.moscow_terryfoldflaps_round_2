//
//  StoreViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import CoreLocation

final class StoreViewModel {
    let id: String
    let name: String
    let iconUrl: String?
    let price: String?
    let position: CLLocationCoordinate2D?
    let deliveryAvailable: Bool

    init(id: String, name: String, iconUrl: String?, price: String?, position: CLLocationCoordinate2D?, deliveryAvailable: Bool) {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.price = price
        self.position = position
        self.deliveryAvailable = deliveryAvailable
    }

    init(with store: Store) {
        self.id = String(store.id)
        self.name = store.name
        self.iconUrl = store.imgUrl
        self.price = String(store.averagePrice) + " " + store.currecy
        self.position = CLLocationCoordinate2D(latitude: Double(store.lat), longitude: Double(store.lon))
        self.deliveryAvailable = store.deliveryAvailable
    }
}
