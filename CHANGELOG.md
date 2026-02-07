# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.6] - 2026-02-07

### Added
- `SpotifyWebAPIWorker.swift` - new top-level interface to provide convenience functions and manage authorization
- `SpotifyWebAPIError.swift` - for API errors specific to this package
- `ClientCredsResponsePresets.swift` - auth. response presets for testing
- `SpotifyWebAPIWorkerTests.swift` - tests for the new `SpotifyWebAPIWorker`
- `SpotifyWebAuthRoutes.swift` - moved auth. related things here from `SpotifyWebAPIRoutes`
- `SpotifyWebAuthError.swift` - for auth. errors specific to this package
- `SpotifyWebAuthRoutesTests.swift` - moved auth. related tests here from `SpotifyWebAPIRoutesTests`

### Changed
- `README.md` - documentation and examples for the new `SpotifyWebAPIWorker` and other updates
- `SpotifyWebAPIRoutes.swift` - moved out auth. related things to `SpotifyWebAuthRoutes`
- `SpotifyWebAPIRoutesTests.swift` - moved out auth. related tests to `SpotifyWebAuthRoutesTests`
- Moved things around in the Xcode project to separate the auth. stuff from the regular API stuff

## [1.0.5] - 2026-02-04

### Added
- `JSONDecoderHelpers.swift`, absorbed code from dependency on private repo that has been removed

### Changed
- Moved data presets into their own product separate from the main `SpotifyWebAPIInterchangeKit` product

### Removed
- dependency on private repo

## [1.0.4] - 2026-02-02

### Added
- Contributing guidelines (`CONTRIBUTING.md`)
- This `CHANGELOG.md` file

### Changed
- Updated `README.md` with basic documentation

## [1.0.3] - 2026-01-31

### Changed
- Renamed project name and everything referencing old name to "SpotifyWebAPIInterchangeKit"

## [1.0.2] - 2026-01-31

### Changed
- Bumped version on `Interchange` dependency

## [1.0.1] - 2026-01-29

### Changed
- Now referencing RESTWebService's new name, `Interchange`

## [1.0.0] - 2025-07-07

Initial 1.0 release.

### Added
- Most functionality added in nearly 25 commits spanning several years. See git log for details.

## [0.0.1] - 2022-02-03

Initial commit
