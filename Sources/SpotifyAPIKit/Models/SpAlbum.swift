//
//  SpAlbum.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SpAlbum: Codable, Identifiable, Equatable {

    public let id: String

    public let uri: String

    public let name: String

    public let albumType: String

    public let totalTracks: Int

    public let href: String

    public let releaseDate: String

    public let images: [SpImage]

    public let artists: [SpArtist]

    public let tracks: SpCollection<SpTrack>

    enum CodingKeys: String, CodingKey {
        case id
        case uri
        case name
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case href
        case releaseDate = "release_date"
        case images
        case artists
        case tracks
    }

    public init(id: String,
                uri: String,
                name: String,
                albumType: String,
                totalTracks: Int,
                href: String,
                releaseDate: String,
                images: [SpImage],
                artists: [SpArtist],
                tracks: SpCollection<SpTrack>) {
        self.id = id
        self.uri = uri
        self.name = name
        self.albumType = albumType
        self.totalTracks = totalTracks
        self.href = href
        self.releaseDate = releaseDate
        self.images = images
        self.artists = artists
        self.tracks = tracks
    }
}
