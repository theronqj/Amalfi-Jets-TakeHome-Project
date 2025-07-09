//
//  AirportSearchSheet.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

/// A sheet view for searching and selecting an airport.
struct AirportSearchSheet: View {
    /// The environment's dismiss action.
    @Environment(\.dismiss) private var dismiss
    /// The view model for airport search.
    @ObservedObject var searchViewModel: AirportSearchViewModel
    /// A closure to be called when an airport is selected.
    let onSelect: (Airport) -> Void

    /// The body of the view.
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("City or airport")
                    .font(.headline)
                    .padding(.vertical, 8)
                    .padding(.leading, 16)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 16)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search Airports", text: $searchViewModel.query)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.bottom, 10)

            List {
                ForEach(searchViewModel.airports) { airport in
                    Button(action: {
                        onSelect(airport)
                        dismiss()
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(airport.name)
                                    .font(.system(size: 17, weight: .semibold))
                                if let servedCity = airport.servedCity, !servedCity.isEmpty, servedCity != airport.name {
                                    Text("\(servedCity), \(airport.countryName)")
                                        .font(.system(size: 15))
                                        .foregroundColor(.secondary)
                                } else {
                                    Text(airport.countryName)
                                        .font(.system(size: 15))
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
                if searchViewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .padding()
                }
                if let error = searchViewModel.errorMessage {
                    HStack {
                        Spacer()
                        Text(error).foregroundColor(.red)
                        Spacer()
                    }
                    .padding()
                }
            }
            .listStyle(.plain)
        }
        .background(Color.white)
        .ajCornerRadius(20, corners: [.topLeft, .topRight])
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
