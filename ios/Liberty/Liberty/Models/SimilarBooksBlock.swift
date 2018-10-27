//
//  SimilarBooksBlock.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import ObjectMapper

public class SimilarBooksBlock: Block {
    var books: [Book]!
    var title: String!

    public required init?(map: Map) {

    }

    public override func mapping(map: Map) {
        books <- map["books"]
        title <- map["title"]
    }
}
