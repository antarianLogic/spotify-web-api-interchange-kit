//
//  JSONDecoderHelpers.swift
//  SpotifyWebAPIDataPresets
//
//  Created by Carl Sheppard on 2/4/26.
//  Copyright © 2026 Antarian Logic LLC. All rights reserved.
//

import Foundation
import os

let dataPresetsLogger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "SpotifyWebAPIDataPresets", category: "Package")

public extension JSONDecoder {

    func decode<T>(_ type: T.Type,
                   fromResource resource: String,
                   inBundle bundle: Bundle = Bundle.main) -> T? where T : Decodable {
        guard let url = bundle.url(forResource: resource, withExtension: "json") else {
            dataPresetsLogger.error("In JSONDecoder.decode(_:fromResource:), json file not found for resource: \(resource, privacy: .public) in bundle: \(bundle)")
            return nil
        }

        return decode(type, fromURL: url)
    }

    func decode<T>(_ type: T.Type,
                   fromURL url: URL) -> T? where T : Decodable {
        guard let jsonData = try? Data(contentsOf: url) else {
            dataPresetsLogger.error("In JSONDecoder.decode(_:fromURL:), json data could not be read for url: \(url)")
            return nil
        }

        do {
            let album = try decode(T.self, from: jsonData)
            return album
        } catch DecodingError.keyNotFound(let key, let context) {
            dataPresetsLogger.warning("In JSONDecoder.decode(_:fromURL:), missing key '\(key.stringValue, privacy: .public)' not found – \(context.debugDescription, privacy: .public)")
            return nil
        } catch DecodingError.typeMismatch(_, let context) {
            dataPresetsLogger.warning("In JSONDecoder.decode(_:fromURL:), type mismatch – \(context.debugDescription, privacy: .public)")
            return nil
        } catch DecodingError.valueNotFound(let type, let context) {
            dataPresetsLogger.warning("In JSONDecoder.decode(_:fromURL:), missing \(type) value – \(context.debugDescription, privacy: .public)")
            return nil
        } catch DecodingError.dataCorrupted(_) {
            dataPresetsLogger.warning("In JSONDecoder.decode(_:fromURL:), invalid JSON")
            return nil
        } catch {
            dataPresetsLogger.warning("In JSONDecoder.decode(_:fromURL:), unknown error: \(error.localizedDescription, privacy: .public)")
            return nil
        }
    }
}
