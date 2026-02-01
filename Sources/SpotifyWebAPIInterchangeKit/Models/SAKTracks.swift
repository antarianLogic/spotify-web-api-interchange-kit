//
//  SAKTracks.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 11/14/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct SAKTracks: Codable, Equatable, Sendable {

    public let tracks: [SAKTrack]

    public init(tracks: [SAKTrack]) {
        self.tracks = tracks
    }
}
