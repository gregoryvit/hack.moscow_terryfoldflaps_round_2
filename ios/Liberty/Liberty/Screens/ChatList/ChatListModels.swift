//
//  ChatListModels.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

final class ChatListSectionModel {
    let sectionName: String
    let models: [ChatGroupModel]

    init(with sectionName: String, models: [ChatGroupModel]) {
        self.sectionName = sectionName
        self.models = models
    }
}

final class ChatGroupModel {
    let avatarUrl: String?
    let title: String
    let description: String
    let newMessages: Int

    init(avatarUrl: String?, title: String, description: String, newMessages: Int) {
        self.avatarUrl = avatarUrl
        self.title = title
        self.description = description
        self.newMessages = newMessages
    }
}
