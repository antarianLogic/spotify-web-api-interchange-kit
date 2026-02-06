//
//  SpotifyWebAPIWorkerTests.swift
//  SpotifyWebAPIInterchangeKitTests
//
//  Created by Carl Sheppard on 2/4/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

import Testing
import Interchange
@testable import SpotifyWebAPIInterchangeKit

struct SpotifyWebAPIWorkerTests {

    @Test func getTopTracksForArtist() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKTracks.Presets.nirvanaTracks)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let tracks = try await sut.getTopTracksForArtist(withID: "FAKE_ARTIST_ID")
        #expect(tracks.count == 10)
        let firstTrack = try #require(tracks.first)
        #expect(firstTrack.id == "5ghIJDpPoe3CfHMGu71E6T")
        let lastTrack = try #require(tracks.last)
        #expect(lastTrack.id == "5Rizj5FLb2AyNKu9esjYY6")
    }

    @Test func failingGetTopTracksForArtist() async throws {
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: MockInterchangeManager(shouldFail: true),
                                      alternateAPIManager: MockInterchangeManager(shouldFail: true))
        let error = await #expect(throws: InterchangeError.self) { try await sut.getTopTracksForArtist(withID: "FAKE_ARTIST_ID") }
        if case let .httpError(code, _, _) = error {
            #expect(code == 404)
        } else {
            Issue.record("Not a InterchangeError.httpError")
        }
    }

    @Test func getAlbum() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKAlbum.Presets.nevermind)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let album = try await sut.getAlbum(withID: "FAKE_ALBUM_ID")
        #expect(album.id == "6yaiubHHJy8N8QcHy3julo")
    }

    @Test func getTrack() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKTrack.Presets.lithium)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let track = try await sut.getTrack(withID: "FAKE_TRACK_ID")
        #expect(track.id == "07hCnHx9DhqZg5eN6RvCbd")
    }

    @Test func searchAlbumsWithUPC() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKSearchResults.Presets.chromatica)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let albums = try await sut.searchAlbums(withUPC: "FAKE_ALBUM_UPC")
        #expect(albums.count == 2)
        let firstAlbum = try #require(albums.first)
        #expect(firstAlbum.id == "05c49JgPmL4Uz2ZeqRx5SP")
        let lastAlbum = try #require(albums.last)
        #expect(lastAlbum.id == "3OevODyllQCrhudfLLnV3y")
    }

    @Test func noItemsReturnedFromSearchAlbumsWithUPC() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKSearchResults.Presets.ladyGaga)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let error = await #expect(throws: SpotifyWebAPIError.self) { try await sut.searchAlbums(withUPC: "FAKE_ALBUM_UPC") }
        #expect(error == .noItemsFound)
    }

    @Test func searchArtists() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKSearchResults.Presets.ladyGaga)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let artists = try await sut.searchArtists(withName: "FAKE_ARTIST_NAME")
        #expect(artists.count == 9)
        let firstArtist = try #require(artists.first)
        #expect(firstArtist.id == "1HY2Jd0NmPuamShAr6KMms")
        let lastArtist = try #require(artists.last)
        #expect(lastArtist.id == "7BXMFyPdBOP61qeL3E5qU7")
    }

    @Test func noItemsReturnedFromSearchArtists() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKSearchResults.Presets.chromatica)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let error = await #expect(throws: SpotifyWebAPIError.self) { try await sut.searchArtists(withName: "FAKE_ARTIST_NAME") }
        #expect(error == .noItemsFound)
    }

    @Test func searchAlbumsWithTitle() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKSearchResults.Presets.chromatica)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let albums = try await sut.searchAlbums(withTitle: "FAKE_ALBUM_TITLE", artistName: "FAKE_ARTIST_NAME")
        #expect(albums.count == 2)
        let firstAlbum = try #require(albums.first)
        #expect(firstAlbum.id == "05c49JgPmL4Uz2ZeqRx5SP")
        let lastAlbum = try #require(albums.last)
        #expect(lastAlbum.id == "3OevODyllQCrhudfLLnV3y")
    }

    @Test func noItemsReturnedFromSearchAlbumsWithTitle() async throws {
        let mockAuthManager = MockInterchangeManager()
        await mockAuthManager.pushMockData(ClientCredsResponse.Presets.validToken)
        let mockAPIManager = MockInterchangeManager()
        await mockAPIManager.pushMockData(SAKSearchResults.Presets.ladyGaga)
        let sut = SpotifyWebAPIWorker(clientID: "FAKE_CLIENT_ID",
                                      clientSecret: "FAKE_CLIENT_SECRET",
                                      alternateAuthManager: mockAuthManager,
                                      alternateAPIManager: mockAPIManager)
        let error = await #expect(throws: SpotifyWebAPIError.self) { try await sut.searchAlbums(withTitle: "FAKE_ALBUM_TITLE", artistName: "FAKE_ARTIST_NAME") }
        #expect(error == .noItemsFound)
    }
}
