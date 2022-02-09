//
//  SAKImage.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import RESTWebService

public struct SAKImage: Codable, Equatable {

    public let url: String

    public let width: Int

    public let height: Int

    public init(url: String,
                width: Int,
                height: Int) {
        self.url = url
        self.width = width
        self.height = height
    }
}

extension SAKImage: Identifiable {

    public var id: String { url }
}
