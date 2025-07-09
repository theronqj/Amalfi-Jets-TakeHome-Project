//
//  ContentView.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

/// The main booking form view for Amalfi Jets.
struct ContentView: View {
    @State private var isDepartureAirportSheetPresented = false
    @State private var isArrivalAirportSheetPresented = false
    @State private var isPassengerCountSheetPresented = false
    @State private var isAircraftModelSheetPresented = false
    @State private var isDepartureDateSheetPresented = false
    @State private var isNotesSheetPresented = false

    @StateObject private var departureAirportSearchVM = AirportSearchViewModel()
    @StateObject private var arrivalAirportSearchVM = AirportSearchViewModel()

    @StateObject private var bookingVM = BookingFormViewModel()

    /// Indicates whether the form is expanded, based on airports being selected.
    private var isFormExpanded: Bool {
        bookingVM.departureAirport != nil && bookingVM.arrivalAirport != nil
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 0) {
                        AirportInputRow(
                            iconName: "airplane",
                            placeholder: "Where from?",
                            airportName: bookingVM.departureAirport?.name,
                            action: { isDepartureAirportSheetPresented = true }
                        )
                        .sheet(isPresented: $isDepartureAirportSheetPresented) {
                            AirportSearchSheet(searchViewModel: departureAirportSearchVM) { airport in
                                bookingVM.departureAirport = airport
                            }
                            .presentationDetents([.fraction(0.85), .large])
                            .presentationDragIndicator(.visible)
                        }

                        Divider()
                            .padding(.horizontal, 16)

                        AirportInputRow(
                            iconName: "airplane",
                            placeholder: "Where to?",
                            airportName: bookingVM.arrivalAirport?.name,
                            action: { isArrivalAirportSheetPresented = true }
                        )
                        .overlay(alignment: .trailing) {
                            Button {
                                let temp = bookingVM.departureAirport
                                bookingVM.departureAirport = bookingVM.arrivalAirport
                                bookingVM.arrivalAirport = temp
                            } label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .padding(8)
                                    .background(Color(UIColor.systemGray4))
                                    .clipShape(Circle())
                            }
                            .padding(.trailing, 16)
                            .opacity(isFormExpanded ? 1 : 0)
                            .animation(.easeOut, value: isFormExpanded)
                        }
                        .sheet(isPresented: $isArrivalAirportSheetPresented) {
                            AirportSearchSheet(searchViewModel: arrivalAirportSearchVM) { airport in
                                bookingVM.arrivalAirport = airport
                            }
                            .presentationDetents([.fraction(0.85), .large])
                            .presentationDragIndicator(.visible)
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .shadow(radius: isFormExpanded ? 0 : 3)

                    if isFormExpanded {
                        VStack(spacing: 20) {
                            DatePickerButton(
                                date: bookingVM.departureDate,
                                action: { isDepartureDateSheetPresented = true }
                            )
                            .sheet(isPresented: $isDepartureDateSheetPresented) {
                                DatePickerSheet(
                                    initialDate: bookingVM.departureDate,
                                    onSet: { newDate in
                                        bookingVM.departureDate = newDate
                                    },
                                    onCancel: {
                                        dismissSheet(sheet: .departureDate)
                                    }
                                )
                                .presentationDetents([.medium, .large])
                                .presentationDragIndicator(.visible)
                            }

                            AircraftModelSelectionButton(
                                selectedCategoryName: bookingVM.selectedAircraftCategory?.aircraft_category_name,
                                action: { isAircraftModelSheetPresented = true }
                            )
                            .sheet(isPresented: $isAircraftModelSheetPresented) {
                                AircraftModelSheet(
                                    selected: bookingVM.selectedAircraftCategory,
                                    categories: AircraftCategory.allCategories,
                                    onSelect: { category in
                                        bookingVM.selectedAircraftCategory = category
                                    }
                                )
                                .presentationDetents([.large])
                                .presentationDragIndicator(.visible)
                            }

                            CountSelectionButton(
                                title: "Passenger Count",
                                count: bookingVM.passengerCount,
                                action: { isPassengerCountSheetPresented = true }
                            )
                            .sheet(isPresented: $isPassengerCountSheetPresented) {
                                PassengerCountSheet(
                                    initialCount: bookingVM.passengerCount,
                                    onSet: { newCount in
                                        bookingVM.passengerCount = newCount
                                    }
                                )
                                .presentationDetents([.fraction(0.35), .medium])
                                .presentationDragIndicator(.visible)
                            }

                            NotesButton(
                                notes: bookingVM.notes,
                                action: { isNotesSheetPresented = true }
                            )
                            .sheet(isPresented: $isNotesSheetPresented) {
                                NotesSheet(
                                    initialNotes: bookingVM.notes,
                                    onSave: { newNotes in
                                        bookingVM.notes = newNotes
                                    },
                                    onCancel: {
                                        dismissSheet(sheet: .notes)
                                    }
                                )
                                .presentationDetents([.medium, .large])
                                .presentationDragIndicator(.visible)
                            }

                            Button(action: {
                                print("Booking Submitted:")
                                print("Departure Airport: \(bookingVM.departureAirport?.name ?? "None")")
                                print("Arrival Airport: \(bookingVM.arrivalAirport?.name ?? "None")")
                                print("Departure Date: \(bookingVM.departureDate)")
                                print("Passenger Count: \(bookingVM.passengerCount)")
                                print("Aircraft Model: \(bookingVM.selectedAircraftCategory?.aircraft_category_name ?? "None")")
                                print("Notes: \(bookingVM.notes)")
                            }) {
                                Text("Submit")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.ajOrange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Amalfi Jets Booking Form")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(Color.ajOrange)
    }

    /// Enumeration representing the different types of sheets that can be presented.
    enum SheetType {
        case departureAirport
        case arrivalAirport
        case passengerCount
        case aircraftModel
        case departureDate
        case notes
    }

    private func dismissSheet(sheet type: SheetType) {
        switch type {
        case .departureAirport: isDepartureAirportSheetPresented = false
        case .arrivalAirport: isArrivalAirportSheetPresented = false
        case .passengerCount: isPassengerCountSheetPresented = false
        case .aircraftModel: isAircraftModelSheetPresented = false
        case .departureDate: isDepartureDateSheetPresented = false
        case .notes: isNotesSheetPresented = false
        }
    }
}

/// A reusable input row view for selecting an airport with an icon, placeholder, and action.
struct AirportInputRow: View {
    /// The name of the system icon to display.
    let iconName: String
    /// The placeholder text to show when no airport is selected.
    let placeholder: String
    /// The name of the selected airport, if any.
    let airportName: String?
    /// The action to perform when the row is tapped.
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: iconName)
                    .font(.headline)
                    .foregroundColor(.gray)

                Text(airportName ?? placeholder)
                    .foregroundColor(airportName == nil ? .gray : .primary)
                    .font(.body)
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
    }
}

/// A button that displays a departure date and triggers an action when tapped.
struct DatePickerButton: View {
    /// The currently selected date to display.
    let date: Date
    /// The action to perform when the button is tapped.
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("Departure Date")
                Spacer()
                Text(date, formatter: DateFormatter.shortDateTime)
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
        }
    }
}

/// A button that displays a count and triggers an action when tapped.
struct CountSelectionButton: View {
    /// The title label for the count.
    let title: String
    /// The current count value to display.
    let count: Int
    /// The action to perform when the button is tapped.
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                Text("\(count)")
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
        }
    }
}

/// A button that displays the selected aircraft category and triggers an action when tapped.
struct AircraftModelSelectionButton: View {
    /// The name of the selected aircraft category, if any.
    let selectedCategoryName: String?
    /// The action to perform when the button is tapped.
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("Aircraft Category")
                Spacer()
                Text(selectedCategoryName ?? "Select")
                    .foregroundColor(selectedCategoryName == nil ? .gray : .primary)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
        }
    }
}

/// A button that displays notes or preferred timing and triggers an action when tapped.
struct NotesButton: View {
    /// The current notes text to display.
    let notes: String
    /// The action to perform when the button is tapped.
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("Notes & Preferred Timing")
                Spacer()
                Text(notes.isEmpty ? "Add notes" : notes)
                    .foregroundColor(notes.isEmpty ? .gray : .primary)
                    .lineLimit(1)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
        }
    }
}

extension DateFormatter {
    static let shortDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
