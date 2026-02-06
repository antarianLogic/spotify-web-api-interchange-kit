# Spotify Web API Interchange Kit

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20visionOS-blue.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager)

## A Swift package containing API methods and response models for interacting with the [Spotify Web API](https://developer.spotify.com/documentation/web-api) via [Interchange](https://github.com/antarianLogic/interchange)

---

## Requirements

- iOS 15.0+ / macOS 12.0+
- Swift 6.0+
- Xcode 14.0+

## Overview

This package contains a collection of Spotify Web API endpoint specifications in the form of `RESTEndpoint` structs to be used with [Interchange](https://github.com/antarianLogic/interchange).
It also contains the `Codable` model types to be returned by `InterchangeManager`s generic `sendRequest` function when using the corresponding `RESTEndpoint` struct.
For each endpoint specification, there is a convenience static function in `SpotifyWebAPIRoutes` that returns a fully-populated `RESTEndpoint` struct.
Finally, a worker/manager is provided called `SpotifyWebAPIWorker` that ties it all together by handling authorization internally and providing convenience functions for each supported API call.

Consumers of this package may either simply use the high-level `SpotifyWebAPIWorker` for ease of use or chose to use the lower-level `SpotifyWebAPIRoutes` functions for more control with a separate `InterchangeManager` for authorization and API calls, and using `sendRequest` to make the actual service calls.

Current Spotify Web API endpoints supported are:

| Path                     | `SpotifyWebAPIRoutes` method | `sendRequest` return type |
| ------------------------ | ---------------------------- | ------------------------- |
| /api/token               | `getAuthToken`               | `ClientCredsResponse`     |
| /artists/{id}/top-tracks | `getArtistTopTracks`         | `SAKTracks`               |
| /albums/{id}             | `getAlbum`                   | `SAKAlbum`                |
| /tracks/{id}             | `getTrack`                   | `SAKTrack`                |
| /search                  | `search`                     | `SAKSearchResults`        |

The official documentation for the [Spotify Web API](https://developer.spotify.com/documentation/web-api) shows many more endpoints available.
This package was originally made public to be an example of a real-world use of `Interchange`.
However, there is no reason why it couldn't be used in production apps and other Spotify endpoints could certainly be added in the future.

## Examples

### Authorization

If the `SpotifyWebAPIWorker` is used, authorization is handled automatically but the Spotify client ID and client secret must be passed during initialization.

To handle authorization a bit more manually, use the `getAuthToken` of `SpotifyWebAPIRoutes` as demonstrated below.

```swift
    let authManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.authBaseURL)

    var accessToken: String?

    func checkAuth() async -> Bool {
        guard accessToken == nil else { return true }

        await authorize()

        return accessToken != nil
    }

    func authorize() async {
        guard accessToken == nil else { return }

        let endpoint = SpotifyWebAPIRoutes.getAuthToken(clientID: "YOUR_CLIENT_ID",
                                                        clientSecret: "YOUR_CLIENT_SECRET")
        do {
            let clientCreds: ClientCredsResponse = try await authManager.sendRequest(with: endpoint)

            accessToken = clientCreds.accessToken
            if clientCreds.tokenType.lowercased() != "bearer" {
                print("Error: unexpected tokenType type: \(clientCreds.tokenType)")
            }
        } catch {
            print("Auth error: \(error.localizedDescription)")
            accessToken = nil
        }
    }
```

### Album Search by UPC and Album Details

With `SpotifyWebAPIWorker`, it's as easy as this:

```swift
    let worker = SpotifyWebAPIWorker(clientID: "YOUR_CLIENT_ID",
                                     clientSecret: "YOUR_CLIENT_SECRET")
    // ...
    do {
        // get albums with UPC
        let albums = try await worker.searchAlbums(withUPC: "SOME_ALBUM_UPC")

        guard let firstAlbum = albums.first else {
            // This shouldn't happen because searchAlbums would have thrown an exception if the array was empty.
            // We have a guard anyway to appease the compiler and to avoid having an explicitly wrapped optional.
            print("Error: searchAlbum returned empty array")
            return
        }

        print("Album name: \(firstAlbum.name)")
        print("Spotify album ID: \(firstAlbum.id)")

        // get album details
        let album = try await worker.getAlbum(withID: firstAlbum.id)

        print("Album release date: \(album.releaseDate)")
        print("Album track count: \(album.totalTracks)")
        print("Album artwork URLs: \(album.images.map { $0.url })")
    } catch {
        print("Search error: \(error.localizedDescription)")
    }
```

For the manual approach, here is an example:

```swift
    let apiManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)

    func searchForAlbumAndGetDetails() async {
        // First check Spotify authorization...
        guard await checkAuth() else {
            print("Error: Spotify authorization failed")
            return
        }

        // Make Spotify search call with a known UPC...
        let albumStub = await searchAlbum(withUPC: "SOME_ALBUM_UPC")

        guard let albumStub else {
            print("Error: searchAlbum returned nil")
            return
        }

        print("Album name: \(albumStub.name)")
        print("Spotify album ID: \(albumStub.id)")

        // Now make Spotify album lookup call for Spotify ID...
        let album = await lookupAlbum(withID: albumStub.id)

        guard let album else {
            print("Error: lookupAlbum returned nil")
            return
        }

        print("Album release date: \(album.releaseDate)")
        print("Album track count: \(album.totalTracks)")
        print("Album artwork URLs: \(album.images.map { $0.url })")
    }

    func searchAlbum(withUPC albumUPC: String) async -> SAKAlbumStub? {
        guard let accessToken else {
            print("Error: access token is nil after authorization passed (logic error?)")
            return nil
        }

        let queryString = "upc:\(albumUPC)"
        let endpoint = SpotifyWebAPIRoutes.search(withQuery: queryString, types: ["album"],
                                                  resultLimit: 1, accessToken: accessToken)
        do {
            let searchResults: SAKSearchResults = try await apiManager.sendRequest(with: endpoint)

            guard let albumStub = searchResults.albums?.items.first else {
                print("Error: received value but albums is either missing or empty")
                return nil
            }

            return albumStub
        } catch {
            print("Search error: \(error.localizedDescription)")
            return nil
        }
    }

    func lookupAlbum(withID albumID: String) async -> SAKAlbum? {
        guard let accessToken else {
            print("Error: access token is nil after authorization passed (logic error?)")
            return nil
        }

        let endpoint = SpotifyWebAPIRoutes.getAlbum(withID: albumID,
                                                    accessToken: accessToken)
        do {
            let sakAlbum: SAKAlbum = try await apiManager.sendRequest(with: endpoint)

            return sakAlbum
        } catch {
            print("getAlbum error: \(error.localizedDescription)")
            return nil
        }
    }
```

### Top Tracks for Artist and Track Details

Here is an example with `SpotifyWebAPIWorker`:

```swift
    let worker = SpotifyWebAPIWorker(clientID: "YOUR_CLIENT_ID",
                                     clientSecret: "YOUR_CLIENT_SECRET")
    // ...
    do {
        // Make Spotify top tracks call with a known artist ID...
        let tracks = try await worker.getTopTracksForArtist(withID: "SOME_ARTIST_ID")

        guard let firstTrack = tracks.first else {
            // This shouldn't happen because getTopTracksForArtist would have thrown an exception if the array was empty.
            // We have a guard anyway to appease the compiler and to avoid having an explicitly wrapped optional.
            print("Error: getTopTracksForArtist returned empty array")
            return
        }

        print("Track name: \(firstTrack.name)")
        print("Spotify track ID: \(firstTrack.id)")

        // Now make Spotify track lookup call for Spotify ID...
        let track = try await worker.getTrack(withID: firstTrack.id)

        print("Track duration (ms): \(track.durationMS)")
        print("Track preview URL: \(track.previewURL ?? "none")")
    } catch {
        print("Search error: \(error.localizedDescription)")
    }
```

Here is an example of the manual approach:

```swift
    let apiManager = InterchangeManager(baseURL: SpotifyWebAPIRoutes.baseURL)

    func topTracksForArtistAndTrackDetails() async {
        // First check Spotify authorization...
        guard await checkAuth() else {
            print("Error: Spotify authorization failed")
            return
        }

        // Make Spotify top tracks call with a known artist ID...
        let tracks = await getTopTracks(withArtistID: "SOME_ARTIST_ID")

        guard let firstTrack = tracks.first else {
            print("Error: getTopTracks returned empty array")
            return
        }

        print("Track name: \(firstTrack.name)")
        print("Spotify track ID: \(firstTrack.id)")

        // Now make Spotify track lookup call for Spotify ID...
        let track = await lookupTrack(withID: firstTrack.id)

        guard let track else {
            print("Error: lookupTrack returned nil")
            return
        }

        print("Track duration (ms): \(track.durationMS)")
        print("Track preview URL: \(track.previewURL ?? "none")")
    }

    func getTopTracks(withArtistID artistID: String) async -> [SAKTrack] {
        guard let accessToken else {
            print("Error: access token is nil after authorization passed (logic error?)")
            return []
        }

        let endpoint = SpotifyWebAPIRoutes.getArtistTopTracks(withID: artistID,
                                                              accessToken: accessToken)
        do {
            let sakTracks: SAKTracks = try await apiManager.sendRequest(with: endpoint)

            return sakTracks.tracks
        } catch {
            print("Search error: \(error.localizedDescription)")
            return []
        }
    }

    func lookupTrack(withID trackID: String) async -> SAKTrack? {
        guard let accessToken else {
            print("Error: access token is nil after authorization passed (logic error?)")
            return nil
        }

        let endpoint = SpotifyWebAPIRoutes.getTrack(withID: trackID,
                                                    accessToken: accessToken)
        do {
            let sakTrack: SAKTrack = try await apiManager.sendRequest(with: endpoint)

            return sakTrack
        } catch {
            print("getTrack error: \(error.localizedDescription)")
            return nil
        }
    }
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Carl Sheppard** - [Antarian Logic LLC](https://github.com/antarianLogic)

## Support

- 📫 Report issues on [GitHub Issues](https://github.com/antarianLogic/spotify-web-api-interchange-kit/issues)
- 💬 Ask questions in [GitHub Discussions](https://github.com/antarianLogic/spotify-web-api-interchange-kit/discussions)
- ⭐ Star the repo if you find it useful!
