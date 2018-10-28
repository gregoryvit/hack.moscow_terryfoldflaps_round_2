//
//  ReviewViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 28/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class ReviewViewModel {
    let authorAvatar: String?
    let authorName: String
    let reviewSource: String
    let reviewText: String

    init(authorAvatar: String?,
         authorName: String,
         reviewSource: String,
         reviewText: String) {
        self.authorAvatar = authorAvatar
        self.authorName = authorName
        self.reviewSource = reviewSource
        self.reviewText = reviewText
    }

    init(with review: Review) {
        self.authorAvatar = nil
        self.authorName = review.author
        self.reviewSource = review.source
        self.reviewText = review.summary
    }
}
