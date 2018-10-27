//
//  DetailsTableCellType.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

enum DetailsTableCellType {
    case store([StoreViewModel], String)
    case social([SocialViewModel], String)
    case person(PersonDetailsViewModel)
    case makeFriends
    case bestReview(ReviewViewModel)
    case similarBooks([SimilarBookViewModel], String)
}
