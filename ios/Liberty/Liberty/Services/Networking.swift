//
//  Networking.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Alamofire
import ObjectMapper

public class NetworkManager {

    // MARK: - Constants

    private struct Constants {
        static let goodAcc: Double = 0.7
    }

    fileprivate static let apiRoot = "http://api.cuddlingkittens.tech/v1"

    public static func search(vector: [Double], _ completion: @escaping ((Any?) -> Void)) {
        assert(vector.count == 1024, "Vector length must be exactly 1024")

        let headers = ["Content-Type": "application/json"]

        let body: [String: Any] = ["vec": vector]

        Alamofire.request("\(apiRoot)/search", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let val = response.result.value, let js = val as? [String: Any] {
                    guard let res = js["result"] as? [String: Any] else {  // acc > 0.77
                        completion(nil)
                        return
                    }
                    guard let acc = res["accuracy"] as? Double, acc > Constants.goodAcc else {  // , acc > 0.7
                        completion(nil)
                        return
                    }
                    print("Accyrency: \(acc)")
                    guard let tempResult = res["type"] as? String else {
                        completion(nil)
                        return
                    }
                    let value: Any? = tempResult == "book" ? Book(JSON: res) : Person(JSON: res)
                    completion(value)
                }
            }
    }

}
