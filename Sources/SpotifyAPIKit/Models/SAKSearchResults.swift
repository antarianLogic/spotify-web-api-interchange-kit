//
//  SAKSearchResults.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct SAKSearchResults: Codable, Equatable, Sendable {

    public let tracks: SAKCollection<SAKTrackStub>?

    public let artists: SAKCollection<SAKArtistStub>?

    public let albums: SAKCollection<SAKAlbumStub>?

    public init(tracks: SAKCollection<SAKTrackStub>?,
                artists: SAKCollection<SAKArtistStub>?,
                albums: SAKCollection<SAKAlbumStub>?) {
        self.tracks = tracks
        self.artists = artists
        self.albums = albums
    }
}
