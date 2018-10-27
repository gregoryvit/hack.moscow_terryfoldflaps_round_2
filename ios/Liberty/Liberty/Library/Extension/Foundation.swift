//
//  Foundation.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

extension NSObject {
    @objc class var nameOfClass: String {
        if let name = NSStringFromClass(self).components(separatedBy: ".").last {
            return name
        }
        return ""
    }

    @objc var nameOfClass: String {
        if let name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last {
            return name
        }
        return ""
    }
}
