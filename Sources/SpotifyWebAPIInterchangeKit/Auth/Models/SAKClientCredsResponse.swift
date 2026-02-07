//
//  ClientCredsResponse.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/10/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Interchange

public struct ClientCredsResponse: Codable, Equatable, Sendable {

    public let accessToken: String

    public let tokenType: String

    public let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }

    public init(accessToken: String,
                tokenType: String,
                expiresIn: Int) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }
}
