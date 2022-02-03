//
//  SpotifyAPIRoutes.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import RESTWebService

public enum SpotifyAPIRoutes {

    public static var accessToken: String?

    public static let baseURL: URL = {
        guard let url = URL(string: "https://api.spotify.com/v1") else { fatalError("Invalid base URL!") }

        return url
    }()

    public static func getAlbum(withID id: String,
                                cacheInterval: TimeInterval? = nil,
                                timeoutInterval: TimeInterval? = nil) -> RESTResource<SpotifyAlbum> {
        return RESTResource(path: "/albums/\(id.lowercased())",
                            headers: headers,
                            queryParameters: [URLQueryItem(name: "market", value: "us")],
                            cacheInterval: cacheInterval,
                            timeoutInterval: timeoutInterval)
    }

    private static var headers: [String : String] {
        var allHeaders: [String : String] = [:]
        if let token = Self.accessToken,
           !token.isEmpty {
            allHeaders["Authorization"] = "Bearer \(token)"
        }
        allHeaders["Content-Type"] = "application/json"
        return allHeaders
    }
}
