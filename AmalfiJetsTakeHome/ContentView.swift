import SwiftUI
import Combine
import Foundation

class BookingFormViewModel: ObservableObject {
    @Published var departureAirport: Airport? = nil
    @Published var arrivalAirport: Airport? = nil
    @Published var departureDate: Date = Date()
    @Published var passengerCount: Int = 1
    @Published var notes: String = ""
}

struct ContentView: View {
    @State private var isDepartureAirportSheetPresented = false
    @State private var isArrivalAirportSheetPresented = false
    @State private var isPassengerCountSheetPresented = false
    @State private var isAircraftModelSheetPresented = false

    @StateObject private var departureAirportSearchVM = AirportSearchViewModel()
    @StateObject private var arrivalAirportSearchVM = AirportSearchViewModel()

    @State private var selectedAircraftCategory: AircraftCategory? = nil

    @StateObject private var bookingVM = BookingFormViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    // Departure Airport
                    Button {
                        isDepartureAirportSheetPresented = true
                    } label: {
                        HStack {
                            Text("Departure Airport")
                            Spacer()
                            Text(bookingVM.departureAirport?.name ?? "Select") // Changed from .id to .name
                                .foregroundColor(bookingVM.departureAirport == nil ? .gray : .primary)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $isDepartureAirportSheetPresented) {
                        NavigationView {
                            AirportSearchSheet(searchViewModel: departureAirportSearchVM) { airport in
                                bookingVM.departureAirport = airport
                                isDepartureAirportSheetPresented = false
                            }
                        }
                    }

                    // Arrival Airport
                    Button {
                        isArrivalAirportSheetPresented = true
                    } label: {
                        HStack {
                            Text("Arrival Airport")
                            Spacer()
                            Text(bookingVM.arrivalAirport?.name ?? "Select") // Changed from .id to .name
                                .foregroundColor(bookingVM.arrivalAirport == nil ? .gray : .primary)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $isArrivalAirportSheetPresented) {
                        NavigationView {
                            AirportSearchSheet(searchViewModel: arrivalAirportSearchVM) { airport in
                                bookingVM.arrivalAirport = airport
                                isArrivalAirportSheetPresented = false
                            }
                        }
                    }

                    // Departure Date
                    VStack(alignment: .leading) {
                        Text("Departure Date")
                            .font(.headline)
                        DatePicker("Select Date", selection: $bookingVM.departureDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)

                    // Passenger Count
                    Button {
                        isPassengerCountSheetPresented = true
                    } label: {
                        HStack {
                            Text("Passenger Count")
                            Spacer()
                            Text("\(bookingVM.passengerCount)")
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $isPassengerCountSheetPresented) {
                        NavigationView {
                            PassengerCountSheet(initialCount: bookingVM.passengerCount) { newCount in
                                bookingVM.passengerCount = newCount
                                isPassengerCountSheetPresented = false
                            }
                        }
                    }

                    // Aircraft Model
                    Button {
                        isAircraftModelSheetPresented = true
                    } label: {
                        HStack {
                            Text("Aircraft Model")
                            Spacer()
                            Text(selectedAircraftCategory?.aircraft_category_name ?? "Select")
                                .foregroundColor(selectedAircraftCategory == nil ? .gray : .primary)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $isAircraftModelSheetPresented) {
                        NavigationView {
                            AircraftModelSheet(selected: selectedAircraftCategory, categories: AircraftCategory.allCategories) { category in
                                selectedAircraftCategory = category
                                isAircraftModelSheetPresented = false
                            }
                        }
                    }

                    // Notes
                    VStack(alignment: .leading) {
                        Text("Notes")
                            .font(.headline)
                        TextEditor(text: $bookingVM.notes)
                            .frame(minHeight: 100)
                            .padding(4)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }

                    // Submit Button
                    Button(action: {
                        print("Booking Submitted:")
                        print("Departure Airport: \(bookingVM.departureAirport?.name ?? "None")") // Changed to .name
                        print("Arrival Airport: \(bookingVM.arrivalAirport?.name ?? "None")")     // Changed to .name
                        print("Departure Date: \(bookingVM.departureDate)")
                        print("Passenger Count: \(bookingVM.passengerCount)")
                        print("Aircraft Model: \(selectedAircraftCategory?.aircraft_category_name ?? "None")")
                        print("Notes: \(bookingVM.notes)")
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 10)

                }
                .padding()
            }
            .navigationTitle("Booking Form")
        }
    }
}
