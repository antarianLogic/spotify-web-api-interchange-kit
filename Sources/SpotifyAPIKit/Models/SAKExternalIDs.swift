//
//  SAKExternalIDs.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 3/20/24.
//  Copyright © 2024 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SAKExternalIDs: Codable, Equatable, Sendable {

    public let upc: String?

    public let isrc: String?

    public init(upc: String?,
                isrc: String?) {
        self.upc = upc
        self.isrc = isrc
    }
}
