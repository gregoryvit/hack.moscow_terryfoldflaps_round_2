//
//  Networking.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import Just
import Alamofire
import ObjectMapper

public class NetworkManager {

    fileprivate static let apiRoot = "http://api.cuddlingkittens.tech/v1"

    public static func search(vector: [Double]) {
        assert(vector.count == 1024, "Vector length must be exactly 1024")

        let headers = ["Content-Type":"application/json",]

        let body: [String : Any] = ["vec": vector]

        Alamofire.request("\(apiRoot)/search", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in

                if let val = response.result.value, let js = val as? [String: Any] {
                    guard let res = js["result"] as? [String: Any] else {  // acc > 0.77
                        return
                    }
                    guard let acc = res["accuracy"] as? Double else {  // , acc > 0.7
                        return
                    }

                    if let t = res["type"] as? String {
                        if t == "book" {
                            let _ = Book(JSON: res)
                            // TODO:
                        }
                        else {
                            let _ = Person(JSON: res)
                            // TODO:
                        }
                    }
                }

//                if (response.result.error == nil) {
//                    debugPrint("HTTP Response Body: \()")
//                }
//                else {
//                    debugPrint("HTTP Request failed: \(response.result.error)")
//                }
        }
    }
}
