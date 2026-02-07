//
//  SpotifyWebAuthRoutesTests.swift
//  SpotifyWebAPIInterchangeKitTests
//
//  Created by Carl Sheppard on 2/7/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

import Testing
@testable import SpotifyWebAPIInterchangeKit

struct Test {

    @Test func baseURL() async throws {
        #expect(SpotifyWebAuthRoutes.baseURL.absoluteString == "https://accounts.spotify.com")
    }

    @Test func getAuthToken() async throws {
        let endpoint = SpotifyWebAuthRoutes.getAuthToken(clientID: "boo123", clientSecret: "password",
                                                         timeoutInterval: 15)
        #expect(endpoint.path == "/api/token")
        #expect(endpoint.headers == ["Authorization" : "Basic Ym9vMTIzOnBhc3N3b3Jk",
                                     "Content-Type": "application/x-www-form-urlencoded"])
        #expect(endpoint.queryParameters.isEmpty)
        #expect(endpoint.body == "grant_type=client_credentials")
        #expect(endpoint.pageSizeQueryItem == nil)
        #expect(endpoint.offsetQueryItem == nil)
        #expect(endpoint.pageQueryItem == nil)
        #expect(endpoint.cacheInterval == nil)
        #expect(endpoint.timeoutInterval == 15)
    }
}
