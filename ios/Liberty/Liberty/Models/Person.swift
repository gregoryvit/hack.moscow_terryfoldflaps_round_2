//
//  Person.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import ObjectMapper

public class Person: Mappable {
    var id: String!
    var name: String!
    var company: String!
    var position: String!
    var bio: String!
    var website: String!
    var imgUrl: String!
    var details: [Block]!

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        company <- map["company"]
        position <- map["position"]
        bio <- map["bio"]
        website <- map["website"]
        imgUrl <- map["img_url"]
        details <- map["details"]
    }
}
