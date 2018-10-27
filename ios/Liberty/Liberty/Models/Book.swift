//
//  Book.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import ObjectMapper

public class Book: Mappable {
    var id: String!
    var author: String!
    var averagePrice: Int!
    var currency: String!
    var imgUrl: String!
    var rating: Float!
    var title: String!
    var details: [Block]?

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        averagePrice <- map["average_price"]
        currency <- map["currency"]
        imgUrl <- map["img_url"]
        rating <- map["rating"]
        title <- map["title"]
        details <- map["details"]
    }
}
