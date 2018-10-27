//
//  ProductViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class ProductViewModel {

    // MARK: - Properties

    let productName: String?
    let productAuthor: String?
    let productPrice: String?
    let productDescription: String?
    let productRating: Int?

    // MARK: - Init

    init(productName: String?, productAuthor: String?, productPrice: String?, productDescription: String?, productRating: Int?) {
        self.productName = productName
        self.productAuthor = productAuthor
        self.productPrice = productPrice
        self.productDescription = productDescription
        self.productRating = productRating
    }

}
