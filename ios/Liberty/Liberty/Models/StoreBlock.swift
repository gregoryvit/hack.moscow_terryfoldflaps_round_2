//
//  StoreBlock.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import ObjectMapper


public class StoresBlock: Block {
    var stores: [Store]!
    var title: String!

    public required init?(map: Map) {

    }

    public override func mapping(map: Map) {
        title <- map["title"]
        stores <- map["stores"]
    }
}

public class Store: Mappable {
    var id: Int!
    var averagePrice: Int!
    var currecy: String!
    var deliveryAvailable: Int!
    var imgUrl: String!
    var lat: Float!
    var lon: Float!
    var name: String!
    var url: String!

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        averagePrice <- map["average_price"]
        currecy <- map["currency"]
        deliveryAvailable <- map["delivery_available"]
        imgUrl <- map["img_url"]
        lat <- map["lat"]
        lon <- map["lon"]
        name <- map["name"]
        url <- map["url"]
    }
}
