//
//  SAKSearchResultsTests.swift
//  SpotifyAPIKitTests
//
//  Created by Carl Sheppard on 2/12/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
@testable import SpotifyAPIKit

final class SAKSearchResultsTests: XCTestCase {

    func testNevermind() throws {
        let searchResults = SAKSearchResults.Presets.chromatica
        XCTAssertNil(searchResults.tracks)
        let albums = try XCTUnwrap(searchResults.albums)
        XCTAssertEqual(albums.total, 2)
        XCTAssertEqual(albums.items.count, 2)
    }
}
