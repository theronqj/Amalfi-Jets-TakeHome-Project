struct AirportSearchSheet: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var searchViewModel: AirportSearchViewModel
    let onSelect: (Airport) -> Void

    let popularAirports: [Airport] = [
        // Sample airports for illustration
        Airport(id: "1", name: "Harry Reid International Airport", icao: "KLAS", iata: "LAS", servedCity: "Las Vegas", countryName: "United States"),
        Airport(id: "2", name: "John F. Kennedy International Airport", icao: "JFK", iata: "JFK", servedCity: "New York", countryName: "United States"),
        Airport(id: "3", name: "Long Beach (Daugherty Field) Airport", icao: "KLGB", iata: "LGB", servedCity: "Long Beach", countryName: "United States")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                Text("City or airport")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 10)

            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search city / airport...", text: $searchViewModel.query)
                    .autocapitalization(.words)
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.bottom, 12)

            // Popular searches section
            if searchViewModel.query.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    Text("POPULAR SEARCHES")
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    ForEach(popularAirports) { airport in
                        AirportRow(airport: airport, onSelect: {
                            onSelect(airport)
                            dismiss()
                        })
                    }
                }
                .padding(.bottom, 10)
            }

            // Search results
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(searchViewModel.airports) { airport in
                        AirportRow(airport: airport, onSelect: {
                            onSelect(airport)
                            dismiss()
                        })
                    }
                    if searchViewModel.isLoading {
                        ProgressView().padding()
                    }
                    if let error = searchViewModel.errorMessage {
                        Text(error).foregroundColor(.red).padding()
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
        }
        .background(Color(.systemBackground))
        .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

// Helper view for airport row
struct AirportRow: View {
    let airport: Airport
    let onSelect: () -> Void
    var code: String {
        if let iata = airport.iata, !iata.isEmpty {
            return iata
        } else if let icao = airport.icao, !icao.isEmpty {
            return icao
        } else {
            return "---"
        }
    }
    var body: some View {
        Button(action: onSelect) {
            HStack(alignment: .top, spacing: 14) {
                Text(code)
                    .font(.headline.bold())
                    .foregroundColor(.primary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
                VStack(alignment: .leading, spacing: 2) {
                    Text(airport.name)
                        .font(.body.weight(.medium))
                        .foregroundColor(.primary)
                    if let servedCity = airport.servedCity, !servedCity.isEmpty {
                        Text("\(servedCity), \(airport.countryName)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    } else {
                        Text(airport.countryName)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
}

// Extension to round sheet corners
typealias UIRectCorner = CACornerMask
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
import SwiftUI
struct RoundedCorner: Shape {
    var radius: CGFloat = 24.0
    var corners: UIRectCorner = [.topLeft, .topRight]
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(rawValue: corners.rawValue), cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
