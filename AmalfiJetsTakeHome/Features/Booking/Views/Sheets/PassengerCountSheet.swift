//
//  PassengerCountSheet.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

/// A sheet view for selecting the number of passengers.
struct PassengerCountSheet: View {
    /// The environment's dismiss action.
    @Environment(\.dismiss) private var dismiss
    /// Local state for the count.
    @State private var localCount: Int
    /// A closure to be called when the count is set.
    let onSet: (Int) -> Void

    /// Initializes the `PassengerCountSheet`.
    /// - Parameters:
    ///   - initialCount: The initial number of passengers.
    ///   - onSet: A closure to be called when the count is set.
    init(initialCount: Int, onSet: @escaping (Int) -> Void) {
        _localCount = State(initialValue: initialCount)
        self.onSet = onSet
    }

    /// The body of the view.
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Passengers")
                    .font(.title)
                    .bold()
                    .padding(.vertical, 12)
                    .padding(.leading, 16)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            }
            .padding(.top, 10)

            HStack(spacing: 20) {
                Button {
                    if localCount > 1 {
                        localCount -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.title2)
                        .foregroundColor(.ajOrange)
                        .frame(width: 44, height: 44)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                .disabled(localCount <= 1)

                Text("\(localCount)")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(minWidth: 50)

                Button {
                    if localCount < 16 {
                        localCount += 1
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.ajOrange)
                        .frame(width: 44, height: 44)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                .disabled(localCount >= 16)
            }
            .padding(.horizontal, 20)

            Spacer()

            Button("Done") {
                onSet(localCount)
                dismiss()
            }
            .font(.headline.weight(.bold))
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
        .padding(.top)
        .background(Color.white)
        .ajCornerRadius(20, corners: [.topLeft, .topRight])
        .presentationDetents([.fraction(0.3)])
    }
}

#Preview {
  PassengerCountSheet(initialCount: 1, onSet: { _ in } )
}
