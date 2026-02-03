//
//  SpotifyWebAPIRoutes.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import Foundation
import Interchange

public enum SpotifyWebAPIRoutes {

    /// A constant representing the Spotify base URL for regular web API requests
    ///
    public static let baseURL: URL = {
        guard let url = URL(string: "https://api.spotify.com/v1") else { fatalError("Invalid base URL!") }

        return url
    }()

    /// A constant representing the Spotify base URL for authorization requests
    ///
    public static let authBaseURL: URL = {
        guard let url = URL(string: "https://accounts.spotify.com") else { fatalError("Invalid auth base URL!") }

        return url
    }()

    /// Creates an endpoint suitable to return a Spotify access token
    ///
    /// - Parameters:
    ///   - clientID: Spotify Client ID string copied from the Spotify developer dashboard
    ///   - clientSecret: Spotify Client Secret string copied from the Spotify developer dashboard
    ///   - timeoutInterval: A optional timeout interval for the request. Omit or pass `nil` to use the default for `URLRequest` (60 seconds).
    /// - Returns: RESTEndpoint
    ///
    /// ## Usage
    ///
    /// Use this endpoint with the ``SpotifyWebAPIRoutes.authBaseURL`` to retrieve the Spotify access token with ``InterchangeManager``'s ``sendRequest(with: endpoint)``, setting the result type to the ``ClientCredsResponse`` model type.
    /// For example:
    ///
    /// ```swift
    /// let authManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.authBaseURL)
    /// var accessToken: String?
    ///
    /// let endpoint = SpotifyWebAPIRoutes.getAuthToken(clientID: "YOUR_CLIENT_ID",
    ///                                                 clientSecret: "YOUR_CLIENT_SECRET")
    /// do {
    ///     let clientCreds: ClientCredsResponse = try await authManager.sendRequest(with: endpoint)
    ///
    ///     accessToken = clientCreds.accessToken
    /// } catch {
    ///     print("Auth error: \(error.localizedDescription)")
    /// }
    /// ```
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

    /// Creates an endpoint suitable to return the top tracks for a given artist with a known Spotify ID
    ///
    /// - Parameters:
    ///   - id: Spotify artist ID string
    ///   - accessToken: Spotify access token previously returned from the ``getAuthToken`` authorization endpoint
    ///   - cacheInterval: A optional cache interval for the request. Omit or pass `nil` to use the default `cachePolicy` for `URLRequest` (`CachePolicy.useProtocolCachePolicy`).
    ///   - timeoutInterval: A optional timeout interval for the request. Omit or pass `nil` to use the default for `URLRequest` (60 seconds).
    /// - Returns: RESTEndpoint
    ///
    /// ## Usage
    ///
    /// Use this endpoint with the ``SpotifyWebAPIRoutes.baseURL`` to retrieve the top tracks for a given Spotify artist ID with ``InterchangeManager``'s ``sendRequest(with: endpoint)``, setting the result type to the ``SAKTracks`` model type.
    /// For example:
    ///
    /// ```swift
    /// let apiManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)
    /// var accessToken: String?
    ///
    /// let endpoint = SpotifyWebAPIRoutes.getArtistTopTracks(withID: "SOME_ARTIST_ID",
    ///                                                       accessToken: accessToken)
    /// do {
    ///     let sakTracks: SAKTracks = try await apiManager.sendRequest(with: endpoint)
    ///
    ///     let tracks = sakTracks.tracks
    ///     print("Spotify tracks: \(tracks)")
    /// } catch {
    ///     print("sendRequest error: \(error.localizedDescription)")
    /// }
    /// ```
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

    /// Creates an endpoint suitable to return album details for a known Spotify album ID
    ///
    /// - Parameters:
    ///   - id: Spotify album ID string
    ///   - accessToken: Spotify access token previously returned from the ``getAuthToken`` authorization endpoint
    ///   - cacheInterval: A optional cache interval for the request. Omit or pass `nil` to use the default `cachePolicy` for `URLRequest` (`CachePolicy.useProtocolCachePolicy`).
    ///   - timeoutInterval: A optional timeout interval for the request. Omit or pass `nil` to use the default for `URLRequest` (60 seconds).
    /// - Returns: RESTEndpoint
    ///
    /// ## Usage
    ///
    /// Use this endpoint with the ``SpotifyWebAPIRoutes.baseURL`` to retrieve the album details for a known Spotify album ID with ``InterchangeManager``'s ``sendRequest(with: endpoint)``, setting the result type to the ``SAKAlbum`` model type.
    /// For example:
    ///
    /// ```swift
    /// let apiManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)
    /// var accessToken: String?
    ///
    /// let endpoint = SpotifyWebAPIRoutes.getAlbum(withID: "SOME_ALBUM_ID",
    ///                                             accessToken: accessToken)
    /// do {
    ///     let sakAlbum: SAKAlbum = try await apiManager.sendRequest(with: endpoint)
    ///
    ///     print("Spotify album details: \(sakAlbum)")
    /// } catch {
    ///     print("sendRequest error: \(error.localizedDescription)")
    /// }
    /// ```
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

    /// Creates an endpoint suitable to return track details for a known Spotify track ID
    ///
    /// - Parameters:
    ///   - id: Spotify track ID string
    ///   - accessToken: Spotify access token previously returned from the ``getAuthToken`` authorization endpoint
    ///   - cacheInterval: A optional cache interval for the request. Omit or pass `nil` to use the default `cachePolicy` for `URLRequest` (`CachePolicy.useProtocolCachePolicy`).
    ///   - timeoutInterval: A optional timeout interval for the request. Omit or pass `nil` to use the default for `URLRequest` (60 seconds).
    /// - Returns: RESTEndpoint
    ///
    /// ## Usage
    ///
    /// Use this endpoint with the ``SpotifyWebAPIRoutes.baseURL`` to retrieve the track details for a known Spotify track ID with ``InterchangeManager``'s ``sendRequest(with: endpoint)``, setting the result type to the ``SAKTrack`` model type.
    /// For example:
    ///
    /// ```swift
    /// let apiManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)
    /// var accessToken: String?
    ///
    /// let endpoint = SpotifyWebAPIRoutes.getTrack(withID: "SOME_TRACK_ID",
    ///                                             accessToken: accessToken)
    /// do {
    ///     let sakTrack: SAKTrack = try await apiManager.sendRequest(with: endpoint)
    ///
    ///     print("Spotify track details: \(sakTrack)")
    /// } catch {
    ///     print("sendRequest error: \(error.localizedDescription)")
    /// }
    /// ```
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

    /// Creates an endpoint suitable to search the Spotify catalog with a supported search query string
    ///
    /// - Parameters:
    ///   - query: Spotify search query string as described in the [Spotify Web API documentation](https://developer.spotify.com/documentation/web-api/reference/search)
    ///   - types: Array of supported Spotify item types to search as described in the [Spotify Web API documentation](https://developer.spotify.com/documentation/web-api/reference/search)
    ///   - resultLimit: Optional number of items to return on each page of the results. Defaults to 100.
    ///   - offset: Optional starting item offset for the next page of results to return. Defaults to 0.
    ///   - accessToken: Spotify access token previously returned from the ``getAuthToken`` authorization endpoint
    ///   - timeoutInterval: A optional timeout interval for the request. Omit or pass `nil` to use the default for `URLRequest` (60 seconds).
    /// - Returns: RESTEndpoint
    ///
    /// ## Usage
    ///
    /// Use this endpoint with the ``SpotifyWebAPIRoutes.baseURL`` to search the Spotify catalog with ``InterchangeManager``'s ``sendRequest(with: endpoint)``, setting the result type to the ``SAKSearchResults`` model type.
    /// For example:
    ///
    /// ```swift
    /// let apiManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)
    /// var accessToken: String?
    ///
    /// let albumUPC = "SOME_ALBUM_UPC"
    /// let queryString = "upc:\(albumUPC)"
    /// let endpoint = SpotifyWebAPIRoutes.search(withQuery: queryString,
    ///                                           types: ["album"],
    ///                                           resultLimit: 1,
    ///                                           accessToken: accessToken)
    /// do {
    ///     let searchResults: SAKSearchResults = try await apiManager.sendRequest(with: endpoint)
    ///
    ///     guard let album = searchResults.albums?.items.first else {
    ///         print("Error: received value but albums is either missing or empty")
    ///         return nil
    ///     }
    ///
    ///     print("Spotify album: \(album)")
    /// } catch {
    ///     print("sendRequest error: \(error.localizedDescription)")
    /// }
    /// ```
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
