//
//  MLMultiArray.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import CoreML

extension MLMultiArray {

    var arrayOfDoubles: [Double] {
        var result = [Double]()
        for i in 0..<self.count {
            result.append(self[i].doubleValue)
        }
        return result
    }
}
