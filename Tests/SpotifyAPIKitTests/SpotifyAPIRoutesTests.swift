//
//  SpotifyAPIRoutesTests.swift
//  SpotifyAPIKitTests
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
import RESTWebService
@testable import SpotifyAPIKit

final class SpotifyAPIRoutesTests: XCTestCase {

    override func setUp() {
        SpotifyAPIRoutes.accessToken = nil
    }

    func testHeaders() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let endpoint = SpotifyAPIRoutes.getAlbum(withID: "1234")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
    }

    func testBaseURL() {
        XCTAssertEqual(SpotifyAPIRoutes.baseURL.absoluteString, "https://api.spotify.com/v1")
    }

    func testGetAuthToken() {
        let endpoint = SpotifyAPIRoutes.getAuthToken(clientID: "boo123", clientSecret: "password", timeoutInterval: 15)
        XCTAssertEqual(endpoint.path, "/api/token")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Basic Ym9vMTIzOnBhc3N3b3Jk",
                                          "Content-Type": "application/x-www-form-urlencoded"])
        XCTAssertTrue(endpoint.queryParameters.isEmpty)
        XCTAssertEqual(endpoint.bodyParameters, [URLQueryItem(name: "grant_type", value: "client_credentials")])
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertNil(endpoint.cacheInterval)
        XCTAssertEqual(endpoint.timeoutInterval, 15)
    }

    func testGetArtistTopTracks() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let endpoint = SpotifyAPIRoutes.getArtistTopTracks(withID: "Zqrs9326", cacheInterval: 3600, timeoutInterval: 30)
        XCTAssertEqual(endpoint.path, "/artists/Zqrs9326/top-tracks")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertTrue(endpoint.bodyParameters.isEmpty)
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertEqual(endpoint.cacheInterval, 3600)
        XCTAssertEqual(endpoint.timeoutInterval, 30)
    }

    func testGetAlbum() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let endpoint = SpotifyAPIRoutes.getAlbum(withID: "Abcd1234", cacheInterval: 3600, timeoutInterval: 30)
        XCTAssertEqual(endpoint.path, "/albums/Abcd1234")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertTrue(endpoint.bodyParameters.isEmpty)
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertEqual(endpoint.cacheInterval, 3600)
        XCTAssertEqual(endpoint.timeoutInterval, 30)
    }

    func testGetTrack() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let endpoint = SpotifyAPIRoutes.getTrack(withID: "Bcde2345", cacheInterval: 3600, timeoutInterval: 40)
        XCTAssertEqual(endpoint.path, "/tracks/Bcde2345")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertTrue(endpoint.bodyParameters.isEmpty)
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertEqual(endpoint.cacheInterval, 3600)
        XCTAssertEqual(endpoint.timeoutInterval, 40)
    }

    func testSearch() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let endpoint = SpotifyAPIRoutes.search(withQuery: "upc: 1234", types: ["album"], resultLimit: 10, offset: 2, timeoutInterval: 50)
        XCTAssertEqual(endpoint.path, "/search")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "q", value: "upc: 1234"),
                                                  URLQueryItem(name: "type", value: "album"),
                                                  URLQueryItem(name: "market", value: "us")])
        XCTAssertTrue(endpoint.bodyParameters.isEmpty)
        XCTAssertEqual(endpoint.pageSizeQueryItem, URLQueryItem(name: "limit", value: "10"))
        XCTAssertEqual(endpoint.offsetQueryItem, URLQueryItem(name: "offset", value: "2"))
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertNil(endpoint.cacheInterval)
        XCTAssertEqual(endpoint.timeoutInterval, 50)
    }
}
