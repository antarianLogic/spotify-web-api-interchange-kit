//
//  SAKTrack.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct SAKTrack: Codable, Identifiable, Equatable, Sendable {

    public let id: String

    public let uri: String

    public let name: String

    public let durationMS: Int

    public let discNumber: Int

    public let trackNumber: Int

    public let popularity: Int

    public let previewURL: String?

    public let album: SAKAlbumStub

    public let artists: [SAKArtistStub]

    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case name
        case durationMS = "duration_ms"
        case discNumber = "disc_number"
        case trackNumber = "track_number"
        case popularity
        case previewURL = "preview_url"
        case album
        case artists
    }

    public init(id: String,
                uri: String,
                name: String,
                durationMS: Int,
                discNumber: Int,
                trackNumber: Int,
                popularity: Int,
                previewURL: String?,
                album: SAKAlbumStub,
                artists: [SAKArtistStub]) {
        self.id = id
        self.uri = uri
        self.name = name
        self.durationMS = durationMS
        self.discNumber = discNumber
        self.trackNumber = trackNumber
        self.popularity = popularity
        self.previewURL = previewURL
        self.album = album
        self.artists = artists
    }
}
