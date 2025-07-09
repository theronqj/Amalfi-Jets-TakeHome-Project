//
//  AirportCategory.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import Foundation

/// A model representing a category of aircraft.
struct AircraftCategory: Identifiable, Equatable {
    /// The unique identifier for the aircraft category.
    let id: Int
    /// The name of the aircraft category.
    let aircraft_category_name: String
    /// The URL for the image representing the aircraft category.
    let aircraft_category_image_url: String
    
    /// A static list of all available aircraft categories.
    static let allCategories: [AircraftCategory] = [
        AircraftCategory(id: 1, aircraft_category_name: "Turboprop", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/turboprop.png"),
        AircraftCategory(id: 2, aircraft_category_name: "Light", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/light.png"),
        AircraftCategory(id: 3, aircraft_category_name: "Midsize", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/midsize.png"),
        AircraftCategory(id: 4, aircraft_category_name: "Super Midsize", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/super_midsize.png"),
        AircraftCategory(id: 5, aircraft_category_name: "Heavy", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/heavy.png"),
        AircraftCategory(id: 6, aircraft_category_name: "Ultra Long Haul", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/ultra_long_haul.png"),
        AircraftCategory(id: 7, aircraft_category_name: "Helicopter", aircraft_category_image_url: "https://dev-atlas.amalfijets.com/admin/assets/images/aircrafts_category/helicopter.png")
    ]
}
