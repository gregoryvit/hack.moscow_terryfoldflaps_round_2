//
//  SocialViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class SocialViewModel {
    let name: String
    let iconUrl: String?

    init(name: String, iconUrl: String?) {
        self.name = name
        self.iconUrl = iconUrl
    }

    init(with social: PersonSocialNetwork) {
        self.name = social.name
        self.iconUrl = social.imgUrl
    }
}
