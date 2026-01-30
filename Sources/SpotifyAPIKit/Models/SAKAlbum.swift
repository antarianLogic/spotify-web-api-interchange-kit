//
//  SAKAlbum.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct SAKAlbum: Codable, Identifiable, Equatable, Sendable {

    public let id: String

    public let uri: String

    public let name: String

    public let albumType: String

    public let totalTracks: Int

    public let releaseDate: String

    public let popularity: Int

    public let images: [SAKImage]

    public let artists: [SAKArtistStub]

    public let tracks: SAKCollection<SAKTrackStub>

    public let externalIDs: SAKExternalIDs?

    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case name
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case releaseDate = "release_date"
        case popularity
        case images
        case artists
        case tracks
        case externalIDs = "external_ids"
    }

    public init(id: String,
                uri: String,
                name: String,
                albumType: String,
                totalTracks: Int,
                releaseDate: String,
                popularity: Int,
                images: [SAKImage],
                artists: [SAKArtistStub],
                tracks: SAKCollection<SAKTrackStub>,
                externalIDs: SAKExternalIDs?) {
        self.id = id
        self.uri = uri
        self.name = name
        self.albumType = albumType
        self.totalTracks = totalTracks
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.images = images
        self.artists = artists
        self.tracks = tracks
        self.externalIDs = externalIDs
    }
}
