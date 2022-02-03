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
}
