//
//  SAKSearchResultsPresets.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/12/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import JSONUtils

public extension SAKSearchResults {

    enum Presets {

        // Albums
        public static let chromatica = JSONDecoder().decode(SAKSearchResults.self, fromResource: "JSON/AlbumSearchResultsChromatica", inBundle: Bundle.module)!

        // Artists
        public static let ladyGaga = JSONDecoder().decode(SAKSearchResults.self, fromResource: "JSON/ArtistSearchResultsLadyGaga", inBundle: Bundle.module)!
    }
}
