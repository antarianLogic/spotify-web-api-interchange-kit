//
//  SpotifyAlbum.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SpotifyAlbum: Codable, Identifiable, Equatable {

    public let id: String

    public let uri: String

    public let name: String

    public let albumType: String

    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case name
        case albumType = "album_type"
    }

    public init(id: String,
                uri: String,
                name: String,
                albumType: String) {
        self.id = id
        self.uri = uri
        self.name = name
        self.albumType = albumType
    }
}
