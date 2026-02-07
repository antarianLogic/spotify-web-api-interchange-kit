//
//  SpotifyWebAPIWorker.swift
//  SpotifyWebAPIInterchangeKit
//
//  Created by Carl Sheppard on 2/4/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

import Interchange

public actor SpotifyWebAPIWorker {

    /// Creates a new worker instance.
    ///
    /// - Parameters:
    ///   - clientID: Spotify Client ID string copied from the Spotify developer dashboard
    ///   - clientSecret: Spotify Client Secret string copied from the Spotify developer dashboard
    ///   - alternateAuthManager: A optional InterchangeManager to use for authorization requests. Omit to use the default for production or inject a MockInterchangeManager for testing or previews.
    ///   - alternateAPIManager: A optional InterchangeManager to use for regular API requests. Omit to use the default for production or inject a MockInterchangeManager for testing or previews.
    ///
    public init(clientID: String,
                clientSecret: String,
                alternateAuthManager: InterchangeManaging = InterchangeManager(baseURL: SpotifyWebAuthRoutes.baseURL),
                alternateAPIManager: InterchangeManaging = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.authManager = alternateAuthManager
        self.apiManager = alternateAPIManager
    }

    private let clientID: String
    private let clientSecret: String
    private let authManager: InterchangeManaging
    private let apiManager: InterchangeManaging
    private var accessToken: String?

    /// Returns the top tracks for a given artist with a known Spotify ID
    ///
    /// - Parameter artistID: Spotify artist ID string
    /// - Returns: array of SAKTrack
    ///
    public func getTopTracksForArtist(withID artistID: String) async throws -> [SAKTrack] {
        // First check Spotify authorization...
        guard try await checkAuth(),
              let accessToken else {
            throw SpotifyWebAuthError.nilAccessToken
        }
        // Now make web API request...
        let endpoint = SpotifyWebAPIRoutes.getArtistTopTracks(withID: artistID,
                                                              accessToken: accessToken)
        let tracks: SAKTracks = try await apiManager.sendRequest(with: endpoint)

        guard !tracks.tracks.isEmpty else {
            throw SpotifyWebAPIError.noItemsFound
        }
        // Return just the tracks array
        return tracks.tracks
    }

    /// Returns album details for a known Spotify album ID
    ///
    /// - Parameter albumID: Spotify album ID string
    /// - Returns: SAKAlbum
    ///
    public func getAlbum(withID albumID: String) async throws -> SAKAlbum {
        // First check Spotify authorization...
        guard try await checkAuth(),
              let accessToken else {
            throw SpotifyWebAuthError.nilAccessToken
        }
        // Now make web API request...
        let endpoint = SpotifyWebAPIRoutes.getAlbum(withID: albumID,
                                                    accessToken: accessToken)
        let album: SAKAlbum = try await apiManager.sendRequest(with: endpoint)

        return album
    }

    /// Returns track details for a known Spotify track ID
    ///
    /// - Parameter trackID: Spotify track ID string
    /// - Returns: SAKTrack
    ///
    public func getTrack(withID trackID: String) async throws -> SAKTrack {
        // First check Spotify authorization...
        guard try await checkAuth(),
              let accessToken else {
            throw SpotifyWebAuthError.nilAccessToken
        }
        // Now make web API request...
        let endpoint = SpotifyWebAPIRoutes.getTrack(withID: trackID,
                                                    accessToken: accessToken)
        let track: SAKTrack = try await apiManager.sendRequest(with: endpoint)

        return track
    }

    /// Searches the Spotify catalog for albums with a known UPC code
    ///
    /// - Parameter albumUPC: a valid album UPC code
    /// - Returns: array of SAKAlbumStub
    ///
    public func searchAlbums(withUPC albumUPC: String) async throws -> [SAKAlbumStub] {
        // First check Spotify authorization...
        guard try await checkAuth(),
              let accessToken else {
            throw SpotifyWebAuthError.nilAccessToken
        }
        // Now make web API request...
        let queryString = "upc:\(albumUPC)"
        let endpoint = SpotifyWebAPIRoutes.search(withQuery: queryString,
                                                  types: ["album"],
                                                  accessToken: accessToken)
        let searchResults: SAKSearchResults = try await apiManager.sendRequest(with: endpoint)

        guard let albums = searchResults.albums,
              !albums.items.isEmpty else {
            throw SpotifyWebAPIError.noItemsFound
        }

        return albums.items
    }

    /// Searches the Spotify catalog for albums with a known artist name
    ///
    /// - Parameter artistName: an artist name or portion of
    /// - Returns: array of SAKArtistStub
    ///
    public func searchArtists(withName artistName: String) async throws -> [SAKArtistStub] {
        // First check Spotify authorization...
        guard try await checkAuth(),
              let accessToken else {
            throw SpotifyWebAuthError.nilAccessToken
        }
        // Now make web API request...
        let queryString = "artist:\(artistName)"
        let endpoint = SpotifyWebAPIRoutes.search(withQuery: queryString,
                                                  types: ["artist"],
                                                  accessToken: accessToken)
        let searchResults: SAKSearchResults = try await apiManager.sendRequest(with: endpoint)

        guard let artists = searchResults.artists,
              !artists.items.isEmpty else {
            throw SpotifyWebAPIError.noItemsFound
        }

        return artists.items
    }

    /// Searches the Spotify catalog for albums with a known title from artists with a known name
    ///
    /// - Parameters:
    ///   - albumTitle: an album title or portion of
    ///   - artistName: an artist name or portion of
    /// - Returns: array of SAKAlbumStub
    ///
    public func searchAlbums(withTitle albumTitle: String, artistName: String) async throws -> [SAKAlbumStub] {
        // First check Spotify authorization...
        guard try await checkAuth(),
              let accessToken else {
            throw SpotifyWebAuthError.nilAccessToken
        }
        // Now make web API request...
        let queryString = "album:\"\(albumTitle)\" artist:\"\(artistName)\""
        let endpoint = SpotifyWebAPIRoutes.search(withQuery: queryString,
                                                  types: ["album"],
                                                  accessToken: accessToken)
        let searchResults: SAKSearchResults = try await apiManager.sendRequest(with: endpoint)

        guard let albums = searchResults.albums,
              !albums.items.isEmpty else {
            throw SpotifyWebAPIError.noItemsFound
        }

        return albums.items
    }

    private func checkAuth() async throws -> Bool {
        guard accessToken == nil else { return true }

        try await authorize()

        return accessToken != nil
    }

    private func authorize() async throws {
        guard accessToken == nil else { return }

        let endpoint = SpotifyWebAuthRoutes.getAuthToken(clientID: clientID,
                                                         clientSecret: clientSecret)
        let clientCreds: ClientCredsResponse = try await authManager.sendRequest(with: endpoint)

        guard clientCreds.tokenType.lowercased() == "bearer" else {
            throw SpotifyWebAuthError.unexpectedTokenType(clientCreds.tokenType)
        }

        accessToken = clientCreds.accessToken
    }
}
