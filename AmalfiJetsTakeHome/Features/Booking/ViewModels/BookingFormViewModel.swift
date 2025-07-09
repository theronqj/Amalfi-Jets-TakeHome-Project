//
//  BookingFormViewModel.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import Foundation
import Combine

/// A view model that manages the state of the booking form.
class BookingFormViewModel: ObservableObject {
    @Published var departureAirport: Airport? = nil
    @Published var arrivalAirport: Airport? = nil
    @Published var departureDate: Date = Date()
    @Published var passengerCount: Int = 1
    @Published var notes: String = ""
    @Published var selectedAircraftCategory: AircraftCategory? = nil
}
