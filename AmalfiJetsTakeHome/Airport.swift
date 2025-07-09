import Foundation

// MARK: - App-Specific Model
// This struct represents the simplified Airport model used in your UI
struct Airport: Identifiable, Equatable, Hashable { // Added Hashable
    let id: String
    let name: String
    let icao: String?
    let iata: String?
    let servedCity: String?
    let countryName: String
}
