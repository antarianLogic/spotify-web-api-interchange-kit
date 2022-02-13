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

        public static let chromatica = JSONDecoder().decode(SAKSearchResults.self, fromResource: "JSON/SearchResultsChromatica", inBundle: Bundle.module)!
    }
}
