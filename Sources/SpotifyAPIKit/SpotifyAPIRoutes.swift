//
//  SpotifyAPIRoutes.swift
//  SpotifyAPIKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import Interchange

public enum SpotifyAPIRoutes {

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
                                    timeoutInterval: TimeInterval? = nil) -> RESTEndpoint {
        let idAndSecret = "\(clientID):\(clientSecret)"
        let encodedValue = Data(idAndSecret.utf8).base64EncodedString()
        let authHeaders: [String : String] = ["Content-Type" : "application/x-www-form-urlencoded",
                                              "Authorization" : "Basic \(encodedValue)"]
        var bodyComponents = URLComponents()
        bodyComponents.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        return RESTEndpoint(method: .post,
                            path: "/api/token",
                            headers: authHeaders,
                            body: bodyComponents.query,
                            timeoutInterval: timeoutInterval)
    }

    public static func getArtistTopTracks(withID id: String,
                                          accessToken: String,
                                          cacheInterval: TimeInterval? = nil,
                                          timeoutInterval: TimeInterval? = nil) -> RESTEndpoint {
        return RESTEndpoint(path: "/artists/\(id)/top-tracks",
                            headers: headers(withAccessToken: accessToken),
                            queryParameters: [URLQueryItem(name: "market", value: "us")],
                            cacheInterval: cacheInterval,
                            timeoutInterval: timeoutInterval)
    }

    public static func getAlbum(withID id: String,
                                accessToken: String,
                                cacheInterval: TimeInterval? = nil,
                                timeoutInterval: TimeInterval? = nil) -> RESTEndpoint {
        return RESTEndpoint(path: "/albums/\(id)",
                            headers: headers(withAccessToken: accessToken),
                            queryParameters: [URLQueryItem(name: "market", value: "us")],
                            cacheInterval: cacheInterval,
                            timeoutInterval: timeoutInterval)
    }

    public static func getTrack(withID id: String,
                                accessToken: String,
                                cacheInterval: TimeInterval? = nil,
                                timeoutInterval: TimeInterval? = nil) -> RESTEndpoint {
        return RESTEndpoint(path: "/tracks/\(id)",
                            headers: headers(withAccessToken: accessToken),
                            queryParameters: [URLQueryItem(name: "market", value: "us")],
                            cacheInterval: cacheInterval,
                            timeoutInterval: timeoutInterval)
    }

    public static func search(withQuery query: String,
                              types: [String],
                              resultLimit: UInt = 100,
                              offset: UInt = 0,
                              accessToken: String,
                              timeoutInterval: TimeInterval? = nil) -> RESTEndpoint {
        let typesString = types.joined(separator: ",")
        return RESTEndpoint(path: "/search",
                            headers: headers(withAccessToken: accessToken),
                            queryParameters: [URLQueryItem(name: "q", value: query),
                                              URLQueryItem(name: "type", value: typesString),
                                              URLQueryItem(name: "market", value: "us")],
                            pageSizeQueryItem: URLQueryItem(name: "limit", value: String(resultLimit)),
                            offsetQueryItem: URLQueryItem(name: "offset", value: String(offset)),
                            timeoutInterval: timeoutInterval)
    }

    private static func headers(withAccessToken accessToken: String) -> [String : String] {
        var allHeaders: [String : String] = [:]
        if !accessToken.isEmpty {
            allHeaders["Authorization"] = "Bearer \(accessToken)"
        }
        allHeaders["Content-Type"] = "application/json"
        return allHeaders
    }
}
