//
//  SimilarBookViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class SimilarBookViewModel {
    let coverImageUrl: String?
    let name: String
    let authorName: String

    init(coverImageUrl: String?, name: String, authorName: String) {
        self.coverImageUrl = coverImageUrl
        self.name = name
        self.authorName = authorName
    }

    init(with book: Book) {
        self.coverImageUrl = book.imgUrl
        self.name = book.title
        self.authorName = book.author
    }
}
