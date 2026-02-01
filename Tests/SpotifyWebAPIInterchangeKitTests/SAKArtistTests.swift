//
//  SAKArtistTests.swift
//  SpotifyWebAPIInterchangeKitTests
//
//  Created by Carl Sheppard on 2/8/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
@testable import SpotifyWebAPIInterchangeKit

final class SAKArtistTests: XCTestCase {

    func testNirvana() throws {
        let artist = SAKArtist.Presets.nirvana
        XCTAssertEqual(artist.id, "6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(artist.uri, "spotify:artist:6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(artist.name, "Nirvana")
        XCTAssertEqual(artist.popularity, 84)
        XCTAssertEqual(artist.images.count, 4)
        let firstImage = try XCTUnwrap(artist.images.first)
        XCTAssertEqual(firstImage.url, "https://i.scdn.co/image/84282c28d851a700132356381fcfbadc67ff498b")
        XCTAssertEqual(firstImage.width, 1000)
        XCTAssertEqual(firstImage.height, 1057)
        let lastImage = try XCTUnwrap(artist.images.last)
        XCTAssertEqual(lastImage.url, "https://i.scdn.co/image/e797ad36d56c3fc8fa06c6fe91263a15bf8391b8")
        XCTAssertEqual(lastImage.width, 64)
        XCTAssertEqual(lastImage.height, 68)
    }
}
