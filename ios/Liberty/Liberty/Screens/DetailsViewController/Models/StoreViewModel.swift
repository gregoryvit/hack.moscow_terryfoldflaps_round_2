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
}
