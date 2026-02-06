//
//  SpotifyWebAPIError.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/4/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

public enum SpotifyWebAPIError: Error {
    case nilAccessToken
    case unexpectedTokenType(String)
    case noItemsFound
}

extension SpotifyWebAPIError: Equatable {}

extension SpotifyWebAPIError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .nilAccessToken:
            return "Spotify access token is nil"
        case .unexpectedTokenType(let tokenType):
            return "Unexpected Spotify access token type: \(tokenType)"
        case .noItemsFound:
            return "No items found in search response"
        }
    }
}
