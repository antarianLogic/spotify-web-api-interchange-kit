//
//  SAKTracksPresets.swift
//  SpotifyWebAPIDataPresets
//
//  Created by Carl Sheppard on 11/14/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import SpotifyWebAPIInterchangeKit

public extension SAKTracks {

    enum Presets {

        public static let nirvanaTracks = JSONDecoder().decode(SAKTracks.self, fromResource: "JSON/ArtistTopTracksNirvana", inBundle: Bundle.module)!
    }
}
