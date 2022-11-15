//
//  SAKTracksTests.swift
//  SpotifyAPIKitTests
//
//  Created by Carl Sheppard on 11/14/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
@testable import SpotifyAPIKit

final class SAKTracksTests: XCTestCase {

    func testNirvanaTopTracks() throws {
        let result = SAKTracks.Presets.nirvanaTracks
        XCTAssertEqual(result.tracks.count, 10)
        let firstTrack = try XCTUnwrap(result.tracks.first)
        XCTAssertEqual(firstTrack.id, "5ghIJDpPoe3CfHMGu71E6T")
        XCTAssertEqual(firstTrack.uri, "spotify:track:5ghIJDpPoe3CfHMGu71E6T")
        XCTAssertEqual(firstTrack.name, "Smells Like Teen Spirit")
        XCTAssertEqual(firstTrack.durationMS, 301920)
        XCTAssertEqual(firstTrack.discNumber, 1)
        XCTAssertEqual(firstTrack.trackNumber, 1)
        XCTAssertEqual(firstTrack.popularity, 78)
        let album = firstTrack.album
        XCTAssertEqual(album.name, "Nevermind (Remastered)")
        XCTAssertEqual(album.releaseDate, "1991-09-26")
        XCTAssertEqual(album.images.count, 3)
        let firstImage = try XCTUnwrap(album.images.first)
        XCTAssertEqual(firstImage.url, "https://i.scdn.co/image/ab67616d0000b273e175a19e530c898d167d39bf")
        XCTAssertEqual(firstImage.width, 640)
        XCTAssertEqual(firstImage.height, 640)
    }
}
