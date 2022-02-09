//
//  SAKAlbumStub.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/9/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SAKAlbumStub: Codable, Identifiable, Equatable {

    public let id: String

    public let uri: String

    public let name: String

    public let albumType: String

    public let totalTracks: Int

    public let releaseDate: String

    public let images: [SAKImage]

    public let artists: [SAKArtistStub]

    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case name
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case releaseDate = "release_date"
        case images
        case artists
    }

    public init(id: String,
                uri: String,
                name: String,
                albumType: String,
                totalTracks: Int,
                releaseDate: String,
                images: [SAKImage],
                artists: [SAKArtistStub]) {
        self.id = id
        self.uri = uri
        self.name = name
        self.albumType = albumType
        self.totalTracks = totalTracks
        self.releaseDate = releaseDate
        self.images = images
        self.artists = artists
    }
}
