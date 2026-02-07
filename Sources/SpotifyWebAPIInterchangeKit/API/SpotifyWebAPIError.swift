//
//  SpotifyWebAPIError.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/4/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

public enum SpotifyWebAPIError: Error {
    case noItemsFound
}

extension SpotifyWebAPIError: Equatable {}

extension SpotifyWebAPIError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .noItemsFound:
            return "No items found in search response"
        }
    }
}
