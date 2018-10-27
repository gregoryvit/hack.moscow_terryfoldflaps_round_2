//
//  Block.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation
import ObjectMapper

public class Block: StaticMappable {

    var type: String!

    public class func objectForMapping(map: Map) -> BaseMappable? {
        if let type: String = map["type"].value() {
            switch type {
            case "stores":
                return StoresBlock(map: map)
            case "best_review":
                return ReviewBlock(map: map)
            case "similar_book":
                return SimilarBooksBlock(map: map)
            default:
                return Block()
            }
        }
        return nil
    }

    init() {

    }

    public func mapping(map: Map) {
        type <- map["type"]
    }

}
