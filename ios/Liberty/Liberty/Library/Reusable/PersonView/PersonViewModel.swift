//
//  PersonViewModel.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class PersonViewModel {

    // MARK: - Properties

    let personName: String?
    let personPosition: String?
    let personIconUrl: String?

    // MARK: - Init

    init(personName: String?, personPosition: String?, personIconUrl: String?) {
        self.personName = personName
        self.personPosition = personPosition
        self.personIconUrl = personIconUrl
    }

    init(with person: Person) {
        self.personName = person.name
        self.personPosition = person.position
        self.personIconUrl = person.imgUrl
    }

}
