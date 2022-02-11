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

    public static let authBaseURL: URL = {
        guard let url = URL(string: "https://accounts.spotify.com") else { fatalError("Invalid auth base URL!") }

        return url
    }()

    public static func getAuthToken(clientID: String,
                                    clientSecret: String,
                                    timeoutInterval: TimeInterval? = nil) -> RESTResource {
        let idAndSecret = "\(clientID):\(clientSecret)"
        let encodedValue = Data(idAndSecret.utf8).base64EncodedString()
        let authHeaders: [String : String] = ["Content-Type" : "application/x-www-form-urlencoded",
                                              "Authorization" : "Basic \(encodedValue)"]
        return RESTResource(method: .post,
                            path: "/api/token",
                            headers: authHeaders,
                            bodyParameters: [URLQueryItem(name: "grant_type", value: "client_credentials")],
                            timeoutInterval: timeoutInterval)
    }

    public static func getAlbum(withID id: String,
                                cacheInterval: TimeInterval? = nil,
                                timeoutInterval: TimeInterval? = nil) -> RESTResource {
        return RESTResource(path: "/albums/\(id.lowercased())",
                            headers: headers,
                            queryParameters: [URLQueryItem(name: "market", value: "us")],
                            cacheInterval: cacheInterval,
                            timeoutInterval: timeoutInterval)
    }

    public static func getTrack(withID id: String,
                                cacheInterval: TimeInterval? = nil,
                                timeoutInterval: TimeInterval? = nil) -> RESTResource {
        return RESTResource(path: "/tracks/\(id.lowercased())",
                            headers: headers,
                            queryParameters: [URLQueryItem(name: "market", value: "us")],
                            cacheInterval: cacheInterval,
                            timeoutInterval: timeoutInterval)
    }

    public static func search(withQuery query: String,
                              types: [String],
                              resultLimit: UInt = 100,
                              offset: UInt = 0,
                              timeoutInterval: TimeInterval? = nil) -> RESTResource {
        let typesString = types.joined(separator: ",")
        return RESTResource(path: "/search",
                            headers: headers,
                            queryParameters: [URLQueryItem(name: "q", value: query),
                                              URLQueryItem(name: "type", value: typesString),
                                              URLQueryItem(name: "market", value: "us")],
                            pageSizeQueryItem: URLQueryItem(name: "limit", value: String(resultLimit)),
                            offsetQueryItem: URLQueryItem(name: "offset", value: String(offset)),
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
