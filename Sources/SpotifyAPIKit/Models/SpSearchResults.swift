//
//  SpSearchResults.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SpSearchResults: Codable, Equatable {

    public let tracks: SpCollection<SpTrack>

    public let albums: SpCollection<SpAlbum>

    public init(tracks: SpCollection<SpTrack>,
                albums: SpCollection<SpAlbum>) {
        self.tracks = tracks
        self.albums = albums
    }
}
