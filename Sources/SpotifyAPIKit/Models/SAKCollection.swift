//
//  SAKCollection.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SAKCollection<SpObj>: Codable, Equatable where SpObj: Codable & Identifiable & Equatable {

    public let total: Int

    public let href: String

    public let items: [SpObj]

    public init(total: Int,
                href: String,
                items: [SpObj]) {
        self.total = total
        self.href = href
        self.items = items
    }
}
