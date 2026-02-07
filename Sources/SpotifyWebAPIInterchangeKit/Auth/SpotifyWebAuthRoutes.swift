//
//  SpotifyWebAuthRoutes.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/7/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

import Foundation
import Interchange

public enum SpotifyWebAuthRoutes {

    /// A constant representing the Spotify base URL for authorization requests
    ///
    public static let baseURL: URL = {
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
    /// Use this endpoint with the ``SpotifyWebAuthRoutes.baseURL`` to retrieve the Spotify access token with ``InterchangeManager``'s ``sendRequest(with: endpoint)``, setting the result type to the ``ClientCredsResponse`` model type.
    /// For example:
    ///
    /// ```swift
    /// let authManager = InterchangeManager(baseURL: SpotifyWebAuthRoutes.baseURL)
    /// var accessToken: String?
    ///
    /// let endpoint = SpotifyWebAuthRoutes.getAuthToken(clientID: "YOUR_CLIENT_ID",
    ///                                                  clientSecret: "YOUR_CLIENT_SECRET")
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
}
