//
//  Airport.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import Foundation

/// A model representing an airport.
struct Airport: Identifiable, Equatable, Hashable {
    /// The unique identifier of the airport.
    let id: String
    /// The name of the airport.
    let name: String
    /// The ICAO code of the airport, if available.
    let icao: String?
    /// The IATA code of the airport, if available.
    let iata: String?
    /// The city served by the airport.
    let servedCity: String?
    /// The name of the country where the airport is located.
    let countryName: String
}
