//
//  SAKTrackTests.swift
//  SpotifyAPIKitTests
//
//  Created by Carl Sheppard on 2/8/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
@testable import SpotifyAPIKit

final class SAKTrackTests: XCTestCase {

    func testLithium() throws {
        let track = SAKTrack.Presets.lithium
        XCTAssertEqual(track.id, "07hCnHx9DhqZg5eN6RvCbd")
        XCTAssertEqual(track.uri, "spotify:track:07hCnHx9DhqZg5eN6RvCbd")
        XCTAssertEqual(track.name, "Lithium")
        XCTAssertEqual(track.durationMS, 257053)
        XCTAssertEqual(track.discNumber, 1)
        XCTAssertEqual(track.trackNumber, 5)
        XCTAssertEqual(track.popularity, 41)
        XCTAssertNil(track.previewURL)
        let album = track.album
        XCTAssertEqual(album.id, "6yaiubHHJy8N8QcHy3julo")
        XCTAssertEqual(album.uri, "spotify:album:6yaiubHHJy8N8QcHy3julo")
        XCTAssertEqual(album.name, "Nevermind")
        XCTAssertEqual(album.albumType, "album")
        XCTAssertEqual(album.totalTracks, 43)
        XCTAssertEqual(album.releaseDate, "1991-09-26")
        XCTAssertEqual(album.images.count, 3)
        let firstImage = try XCTUnwrap(album.images.first)
        XCTAssertEqual(firstImage.url, "https://i.scdn.co/image/ab67616d0000b273d27b5404a8aa5b94856e24cc")
        XCTAssertEqual(firstImage.width, 640)
        XCTAssertEqual(firstImage.height, 640)
        let lastImage = try XCTUnwrap(album.images.last)
        XCTAssertEqual(lastImage.url, "https://i.scdn.co/image/ab67616d00004851d27b5404a8aa5b94856e24cc")
        XCTAssertEqual(lastImage.width, 64)
        XCTAssertEqual(lastImage.height, 64)
        XCTAssertEqual(album.artists.count, 1)
        let firstArtistStub = try XCTUnwrap(album.artists.first)
        XCTAssertEqual(firstArtistStub.id, "6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(firstArtistStub.uri, "spotify:artist:6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(firstArtistStub.name, "Nirvana")
        XCTAssertEqual(track.artists.count, 1)
        let firstTrackArtistStub = try XCTUnwrap(track.artists.first)
        XCTAssertEqual(firstTrackArtistStub.id, "6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(firstTrackArtistStub.uri, "spotify:artist:6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(firstTrackArtistStub.name, "Nirvana")
    }
}
