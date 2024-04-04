//
//  SearchInfoResponse.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation

struct AppSearchResponse: Codable {
    let resultCount: Int
    let results: [AppResult]
}

struct AppResult: Codable {
    let screenshotUrls: [String]
    let ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [String]
    let artworkUrl60: String
    let artworkUrl512: String
    let artworkUrl100: String
    let artistViewUrl: String
    let supportedDevices: [String]
    let averageUserRatingForCurrentVersion: Double?
    let averageUserRating: Double?
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerUrl: String?
    let formattedPrice: String?
    let contentAdvisoryRating: String
    let userRatingCountForCurrentVersion: Int
    let trackViewUrl: String
    let trackContentRating: String
    let currentVersionReleaseDate: String
    let releaseDate: String
    let releaseNotes: String?
    let artistId: Int
    let artistName: String
    let genres: [String]
    let price: Double?
    let primaryGenreName: String
    let primaryGenreId: Int
    let description: String
    let sellerName: String
    let genreIds: [String]
    let bundleId: String
    let trackId: Int
    let trackName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let minimumOsVersion: String
    let currency: String
    let version: String
    let wrapperType: String
    let userRatingCount: Int
}

extension AppResult: Equatable {
    static func == (lhs: AppResult, rhs: AppResult) -> Bool {
        return lhs.trackName == rhs.trackName &&
               lhs.trackId == rhs.trackId &&
               lhs.artistId == rhs.artistId
    }
}
