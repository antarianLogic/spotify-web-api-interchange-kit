//
//  SAKTrackPresets.swift
//  SpotifyWebAPIDataPresets
//
//  Created by Carl Sheppard on 2/8/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import SpotifyWebAPIInterchangeKit

public extension SAKTrack {

    enum Presets {

        public static let lithium = JSONDecoder().decode(SAKTrack.self, fromResource: "JSON/TrackLithium", inBundle: Bundle.module)!
    }
}
