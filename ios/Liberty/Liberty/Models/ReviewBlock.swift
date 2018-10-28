//
//  ReviewBlock.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import ObjectMapper

public class Review: Mappable {
    var id: Int!
    var author: String!
    var source: String!
    var summary: String!
    var imgUrl: String!

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        source <- map["source"]
        summary <- map["summary"]
        imgUrl <- map["img_url"]
    }
}

public class ReviewBlock: Block {
    var review: [Review]!
    var title: String!

    public required init?(map: Map) {

    }

    public override func mapping(map: Map) {
        title <- map["title"]
        review <- map["review"]
    }
}
