//
//  ClientCredsResponsePresets.swift
//  SpotifyWebAPIDataPresets
//
//  Created by Carl Sheppard on 2/4/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

import Foundation
import SpotifyWebAPIInterchangeKit

public extension ClientCredsResponse {
    enum Presets {
        public static let validToken = ClientCredsResponse(accessToken: "MOCK_ACCESS_TOKEN", tokenType: "bearer", expiresIn: 60)
        public static let invalidToken = ClientCredsResponse(accessToken: "MOCK_ACCESS_TOKEN", tokenType: "invalid", expiresIn: 60)
    }
}
