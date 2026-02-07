//
//  SpotifyWebAPIRoutesTests.swift
//  SpotifyWebAPIInterchangeKitTests
//
//  Created by Carl Sheppard on 2/3/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
import Interchange
@testable import SpotifyWebAPIInterchangeKit

final class SpotifyWebAPIRoutesTests: XCTestCase {

    func testHeaders() {
        let endpoint = SpotifyWebAPIRoutes.getAlbum(withID: "1234", accessToken: "NgCXRKMzYjw")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
    }

    func testGetArtistTopTracks() {
        let endpoint = SpotifyWebAPIRoutes.getArtistTopTracks(withID: "Zqrs9326", accessToken: "NgCXRKMzYjw",
                                                           cacheInterval: 3600, timeoutInterval: 30)
        XCTAssertEqual(endpoint.path, "/artists/Zqrs9326/top-tracks")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertNil(endpoint.body)
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertEqual(endpoint.cacheInterval, 3600)
        XCTAssertEqual(endpoint.timeoutInterval, 30)
    }

    func testGetAlbum() {
        let endpoint = SpotifyWebAPIRoutes.getAlbum(withID: "Abcd1234", accessToken: "NgCXRKMzYjw",
                                                 cacheInterval: 3600, timeoutInterval: 30)
        XCTAssertEqual(endpoint.path, "/albums/Abcd1234")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertNil(endpoint.body)
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertEqual(endpoint.cacheInterval, 3600)
        XCTAssertEqual(endpoint.timeoutInterval, 30)
    }

    func testGetTrack() {
        let endpoint = SpotifyWebAPIRoutes.getTrack(withID: "Bcde2345", accessToken: "NgCXRKMzYjw",
                                                 cacheInterval: 3600, timeoutInterval: 40)
        XCTAssertEqual(endpoint.path, "/tracks/Bcde2345")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertNil(endpoint.body)
        XCTAssertNil(endpoint.pageSizeQueryItem)
        XCTAssertNil(endpoint.offsetQueryItem)
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertEqual(endpoint.cacheInterval, 3600)
        XCTAssertEqual(endpoint.timeoutInterval, 40)
    }

    func testSearch() {
        let endpoint = SpotifyWebAPIRoutes.search(withQuery: "upc: 1234", types: ["album"], resultLimit: 10, offset: 2,
                                               accessToken: "NgCXRKMzYjw", timeoutInterval: 50)
        XCTAssertEqual(endpoint.path, "/search")
        XCTAssertEqual(endpoint.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(endpoint.queryParameters, [URLQueryItem(name: "q", value: "upc: 1234"),
                                                  URLQueryItem(name: "type", value: "album"),
                                                  URLQueryItem(name: "market", value: "us")])
        XCTAssertNil(endpoint.body)
        XCTAssertEqual(endpoint.pageSizeQueryItem, URLQueryItem(name: "limit", value: "10"))
        XCTAssertEqual(endpoint.offsetQueryItem, URLQueryItem(name: "offset", value: "2"))
        XCTAssertNil(endpoint.pageQueryItem)
        XCTAssertNil(endpoint.cacheInterval)
        XCTAssertEqual(endpoint.timeoutInterval, 50)
    }
}
