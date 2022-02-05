//
//  SAKSearchResults.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SAKSearchResults: Codable, Equatable {

    public let tracks: SAKCollection<SAKTrack>

    public let albums: SAKCollection<SAKAlbum>

    public init(tracks: SAKCollection<SAKTrack>,
                albums: SAKCollection<SAKAlbum>) {
        self.tracks = tracks
        self.albums = albums
    }
}
