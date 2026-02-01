//
//  SAKArtistPresets.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/8/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import JSONUtils

public extension SAKArtist {

    enum Presets {

        public static let nirvana = JSONDecoder().decode(SAKArtist.self, fromResource: "JSON/ArtistNirvana", inBundle: Bundle.module)!
    }
}
