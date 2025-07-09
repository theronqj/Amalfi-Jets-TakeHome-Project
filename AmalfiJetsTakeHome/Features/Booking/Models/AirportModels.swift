//
//  AirportModels.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import Foundation

/// The decoded response from the Aviowiki airport API.
struct AviowikiSearchResponse: Decodable {
    /// Pagination information for the results.
    let page: PageInfo
    /// List of airport results.
    let content: [AirportAPIResult]
}

/// Metadata about the current page of API results.
struct PageInfo: Decodable {
    /// Page number.
    let number: Int
    /// Results per page.
    let size: Int
    /// Total number of pages available.
    let totalPages: Int
    /// Total number of results available.
    let totalResults: Int
}

/// Represents a single airport result from the Aviowiki API.
struct AirportAPIResult: Decodable {
    /// Maps API keys to local property names.
    enum CodingKeys: String, CodingKey {
        /// Airport name
        case name
        /// Aviowiki 'aid' (maps to 'id')
        case id = "aid"
        /// ICAO code
        case icao
        /// IATA code
        case iata
        /// City served by the airport
        case servedCity
        /// Country information
        case country
        /// Airport coordinates
        case coordinates
    }

    /// Airport name
    let name: String
    /// Airport identifier
    let id: String
    /// ICAO code of the airport
    let icao: String?
    /// IATA code of the airport
    let iata: String?
    /// City served by the airport
    let servedCity: String?
    /// Country information associated with the airport
    let country: CountryInfo
    /// Geographical coordinates of the airport
    let coordinates: Coordinates
}

/// Information about a country associated with an airport.
struct CountryInfo: Decodable {
    /// Two-letter ISO country code
    let iso2: String
    /// Three-letter ISO country code
    let iso3: String
    /// Numeric ISO country code
    let isoNumeric: Int
    /// Common country name
    let name: String
    /// Official country name
    let officialName: String
    /// Local identifier name for the country (optional)
    let localIdentifierName: String?
}

/// Geographical coordinates of an airport.
struct Coordinates: Decodable {
    /// Latitude in decimal degrees
    let latitude: Double
    /// Longitude in decimal degrees
    let longitude: Double
}
