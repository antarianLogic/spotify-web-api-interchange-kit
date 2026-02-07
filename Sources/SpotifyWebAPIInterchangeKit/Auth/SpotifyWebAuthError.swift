//
//  SpotifyWebAuthError.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/7/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

public enum SpotifyWebAuthError: Error {
    case nilAccessToken
    case unexpectedTokenType(String)
}

extension SpotifyWebAuthError: Equatable {}

extension SpotifyWebAuthError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .nilAccessToken:
            return "Spotify access token is nil"
        case .unexpectedTokenType(let tokenType):
            return "Unexpected Spotify access token type: \(tokenType)"
        }
    }
}
