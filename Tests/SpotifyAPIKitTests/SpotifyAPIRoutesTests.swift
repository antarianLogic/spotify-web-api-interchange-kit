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
        let resource = SpotifyAPIRoutes.getAlbum(withID: "1234")
        XCTAssertEqual(resource.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
    }

    func testBaseURL() {
        XCTAssertEqual(SpotifyAPIRoutes.baseURL.absoluteString, "https://api.spotify.com/v1")
    }

    func testGetAlbum() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let resource = SpotifyAPIRoutes.getAlbum(withID: "Abcd1234", cacheInterval: 3600, timeoutInterval: 30)
        XCTAssertEqual(resource.path, "/albums/abcd1234")
        XCTAssertEqual(resource.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(resource.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertNil(resource.pageSizeQueryItem)
        XCTAssertNil(resource.offsetQueryItem)
        XCTAssertNil(resource.pageQueryItem)
        XCTAssertNil(resource.model)
        XCTAssertEqual(resource.cacheInterval, 3600)
        XCTAssertEqual(resource.timeoutInterval, 30)
    }

    func testGetTrack() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let resource = SpotifyAPIRoutes.getTrack(withID: "Bcde2345", cacheInterval: 3600, timeoutInterval: 40)
        XCTAssertEqual(resource.path, "/tracks/bcde2345")
        XCTAssertEqual(resource.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(resource.queryParameters, [URLQueryItem(name: "market", value: "us")])
        XCTAssertNil(resource.pageSizeQueryItem)
        XCTAssertNil(resource.offsetQueryItem)
        XCTAssertNil(resource.pageQueryItem)
        XCTAssertNil(resource.model)
        XCTAssertEqual(resource.cacheInterval, 3600)
        XCTAssertEqual(resource.timeoutInterval, 40)
    }

    func testSearch() {
        SpotifyAPIRoutes.accessToken = "NgCXRKMzYjw"
        let resource = SpotifyAPIRoutes.search(withQuery: "upc: 1234", types: ["album"], resultLimit: 10, offset: 2, timeoutInterval: 50)
        XCTAssertEqual(resource.path, "/search")
        XCTAssertEqual(resource.headers, ["Authorization" : "Bearer NgCXRKMzYjw",
                                          "Content-Type": "application/json"])
        XCTAssertEqual(resource.queryParameters, [URLQueryItem(name: "q", value: "upc: 1234"),
                                                  URLQueryItem(name: "type", value: "album"),
                                                  URLQueryItem(name: "market", value: "us")])
        XCTAssertEqual(resource.pageSizeQueryItem, URLQueryItem(name: "limit", value: "10"))
        XCTAssertEqual(resource.offsetQueryItem, URLQueryItem(name: "offset", value: "2"))
        XCTAssertNil(resource.pageQueryItem)
        XCTAssertNil(resource.model)
        XCTAssertNil(resource.cacheInterval)
        XCTAssertEqual(resource.timeoutInterval, 50)
    }
}
