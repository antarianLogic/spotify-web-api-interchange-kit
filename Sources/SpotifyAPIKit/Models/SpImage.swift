//
//  SpImage.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SpImage: Codable, Equatable {

    public let url: String

    public let height: Int

    public let width: Int

    public init(url: String,
                height: Int,
                width: Int) {
        self.url = url
        self.height = height
        self.width = width
    }
}

extension SpImage: Identifiable {

    public var id: String { url }
}
