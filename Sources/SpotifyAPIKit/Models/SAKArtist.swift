//
//  SAKArtist.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/4/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct SAKArtist: Codable, Identifiable, Equatable, Sendable {

    public let id: String

    public let uri: String

    public let name: String

    public let popularity: Int

    public let images: [SAKImage]

    public init(id: String,
                uri: String,
                name: String,
                popularity: Int,
                images: [SAKImage]) {
        self.id = id
        self.uri = uri
        self.name = name
        self.popularity = popularity
        self.images = images
    }
}
