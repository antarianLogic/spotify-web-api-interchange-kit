//
//  SAKCollection.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct SAKCollection<SpObj>: Codable, Equatable, Sendable where SpObj: Codable & Identifiable & Equatable & Sendable {

    public let total: Int

    public let items: [SpObj]

    public init(total: Int,
                items: [SpObj]) {
        self.total = total
        self.items = items
    }
}
