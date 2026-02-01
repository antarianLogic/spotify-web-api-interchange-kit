//
//  SAKAlbumTests.swift
//  SpotifyWebAPIInterchangeKitTests
//
//  Created by Carl Sheppard on 2/8/22.
//  Copyright © 2022 Antarian Logic LLC. All rights reserved.
//

import XCTest
@testable import SpotifyWebAPIInterchangeKit

final class SAKAlbumTests: XCTestCase {

    func testNevermind() throws {
        let album = SAKAlbum.Presets.nevermind
        XCTAssertEqual(album.id, "6yaiubHHJy8N8QcHy3julo")
        XCTAssertEqual(album.uri, "spotify:album:6yaiubHHJy8N8QcHy3julo")
        XCTAssertEqual(album.name, "Nevermind")
        XCTAssertEqual(album.albumType, "album")
        XCTAssertEqual(album.totalTracks, 43)
        XCTAssertEqual(album.releaseDate, "1991-09-26")
        XCTAssertEqual(album.popularity, 54)
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
        XCTAssertEqual(album.tracks.total, 43)
        XCTAssertEqual(album.tracks.items.count, 43)
        let firstTrack = try XCTUnwrap(album.tracks.items.first)
        XCTAssertEqual(firstTrack.id, "75aLTVBSGIquqzQ6AkmK3Q")
        XCTAssertEqual(firstTrack.uri, "spotify:track:75aLTVBSGIquqzQ6AkmK3Q")
        XCTAssertEqual(firstTrack.name, "Smells Like Teen Spirit")
        XCTAssertEqual(firstTrack.durationMS, 301920)
        XCTAssertEqual(firstTrack.discNumber, 1)
        XCTAssertEqual(firstTrack.trackNumber, 1)
        XCTAssertNil(firstTrack.previewURL)
        XCTAssertEqual(firstTrack.artists.count, 1)
        let firstTrackArtistStub = try XCTUnwrap(firstTrack.artists.first)
        XCTAssertEqual(firstTrackArtistStub.id, "6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(firstTrackArtistStub.uri, "spotify:artist:6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(firstTrackArtistStub.name, "Nirvana")
        let lastTrack = try XCTUnwrap(album.tracks.items.last)
        XCTAssertEqual(lastTrack.id, "5RX5x24vOXBWrZNzF2Wmta")
        XCTAssertEqual(lastTrack.uri, "spotify:track:5RX5x24vOXBWrZNzF2Wmta")
        XCTAssertEqual(lastTrack.name, "Breed - Live At The Paramount")
        XCTAssertEqual(lastTrack.durationMS, 183800)
        XCTAssertEqual(lastTrack.discNumber, 3)
        XCTAssertEqual(lastTrack.trackNumber, 3)
        XCTAssertNil(lastTrack.previewURL)
        XCTAssertEqual(lastTrack.artists.count, 1)
        let lastTrackArtistStub = try XCTUnwrap(firstTrack.artists.last)
        XCTAssertEqual(lastTrackArtistStub.id, "6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(lastTrackArtistStub.uri, "spotify:artist:6olE6TJLqED3rqDCT0FyPh")
        XCTAssertEqual(lastTrackArtistStub.name, "Nirvana")
        XCTAssertEqual(album.externalIDs?.upc, "00602527854090")
        XCTAssertNil(album.externalIDs?.isrc)
    }
}
