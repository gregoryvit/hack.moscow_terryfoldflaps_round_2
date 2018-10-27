//
//  Product.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

public class Product {

    var name: String
    var embedding: [Double] = []

    init(name: String, embedding: [Double]? = nil) {
        self.name = name
        if let v = embedding {
            self.embedding = v
        }
    }
}
