//
//  PersonSocialNetworksContainerBlock.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import ObjectMapper

public class PersonSocialNetworksContainerBlock: Block {
    var title: String!
    var socialNetworks: [PersonSocialNetwork]!

    public required init?(map: Map) {

    }

    public override func mapping(map: Map) {
        title <- map["title"]
        socialNetworks <- map["social_networks"]
    }
}


public class PersonSocialNetwork: Mappable {
    var id: Int!
    var name: String!
    var imgUrl: String!
    var url: String!

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        imgUrl <- map["img_url"]
        url <- map["url"]
    }
}
