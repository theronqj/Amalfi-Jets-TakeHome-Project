//
//  DatePickerSheet.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

/// A sheet view for selecting a departure date and time.
struct DatePickerSheet: View {
    /// The environment's dismiss action.
    @Environment(\.dismiss) private var dismiss
    /// The currently selected date.
    @State private var selectedDate: Date
    /// A closure to be called when the date is set.
    let onSet: (Date) -> Void
    /// A closure to be called when the sheet is cancelled.
    let onCancel: () -> Void

    /// Initializes the `DatePickerSheet`.
    /// - Parameters:
    ///   - initialDate: The initially selected date.
    ///   - onSet: A closure to be called when the date is set.
    ///   - onCancel: A closure to be called when the sheet is cancelled.
    init(initialDate: Date, onSet: @escaping (Date) -> Void, onCancel: @escaping () -> Void) {
        _selectedDate = State(initialValue: initialDate)
        self.onSet = onSet
        self.onCancel = onCancel
    }

    /// The body of the view.
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Choose departure date")
                    .font(.headline)
                    .padding(.vertical, 8)
                    .padding(.leading, 16)
                Spacer()
                Button {
                    onCancel()
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 16)

            DatePicker(
                "Select Date",
                selection: $selectedDate,
                in: Date()...,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding(.horizontal)
            .labelsHidden()
            .accentColor(.ajOrange)

            Spacer()

            Button("Set Date") {
                onSet(selectedDate)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
        .background(Color.white)
        .ajCornerRadius(20, corners: [.topLeft, .topRight])
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
