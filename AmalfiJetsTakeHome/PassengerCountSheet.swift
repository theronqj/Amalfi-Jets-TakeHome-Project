import SwiftUI

struct PassengerCountSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var count: Int
    let onSet: (Int) -> Void
    
    init(initialCount: Int, onSet: @escaping (Int) -> Void) {
        self._count = State(initialValue: initialCount)
        self.onSet = onSet
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Select Passengers").font(.headline).padding(.top)
                Stepper(value: $count, in: 1...16) {
                    Text("\(count) Passenger\(count == 1 ? "" : "s")")
                        .font(.title2)
                        .bold()
                }
                Spacer()
                Button("Done") {
                    onSet(count)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Passenger Count")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
