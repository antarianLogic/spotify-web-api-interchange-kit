//
//  SAKArtist.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/4/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SAKArtist: Codable, Identifiable, Equatable {

    public let id: String

    public let uri: String

    public let name: String

    public init(id: String,
                uri: String,
                name: String) {
        self.id = id
        self.uri = uri
        self.name = name
    }
}
