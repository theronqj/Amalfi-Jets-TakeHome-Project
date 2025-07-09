//
//  AircraftModelSheet.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

/// A sheet view for selecting an aircraft category.
struct AircraftModelSheet: View {
    /// The environment's dismiss action.
    @Environment(\.dismiss) private var dismiss
    /// The currently selected aircraft category.
    @State private var selectedCategory: AircraftCategory?
    /// The list of available aircraft categories.
    let categories: [AircraftCategory]
    /// A closure to be called when an aircraft category is selected.
    let onSelect: (AircraftCategory) -> Void

    /// Initializes the `AircraftModelSheet`.
    /// - Parameters:
    ///   - selected: The initially selected aircraft category.
    ///   - categories: The list of available aircraft categories.
    ///   - onSelect: A closure to be called when an aircraft category is selected.
    init(selected: AircraftCategory?, categories: [AircraftCategory], onSelect: @escaping (AircraftCategory) -> Void) {
        self._selectedCategory = State(initialValue: selected)
        self.categories = categories
        self.onSelect = onSelect
    }

    /// The body of the view.
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Choose Aircraft Category")
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

            List(categories) { category in
                Button(action: {
                    onSelect(category)
                    dismiss()
                }) {
                    HStack {
                        Text(category.aircraft_category_name)
                            .font(.title3)
                            .padding(.trailing, 8)
                        Spacer()

                        AsyncImage(url: URL(string: category.aircraft_category_image_url)) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray.frame(width: 160, height: 160)
                        }
                        .frame(width: 160, height: 160)
                        .cornerRadius(8)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(.plain)
        }
        .background(Color.white)
        .ajCornerRadius(20, corners: [.topLeft, .topRight])
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
