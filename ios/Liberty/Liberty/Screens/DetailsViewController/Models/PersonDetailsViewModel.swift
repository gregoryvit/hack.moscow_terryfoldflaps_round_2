//
//  PersonDetailsViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class PersonDetailsViewModel {
    let avatarUrl: String?
    let name: String
    let work: String
    let position: String
    let description: String
    let website: String

    init(avatarUrl: String?,
         name: String,
         work: String,
         position: String,
         description: String,
         website: String) {
        self.avatarUrl = avatarUrl
        self.name = name
        self.work = work
        self.position = position
        self.description = description
        self.website = website
    }

    init(with person: Person) {
        self.avatarUrl = person.imgUrl
        self.name = person.name
        self.work = person.company
        self.position = person.position
        self.description = person.bio
        self.website = person.website
    }
}
