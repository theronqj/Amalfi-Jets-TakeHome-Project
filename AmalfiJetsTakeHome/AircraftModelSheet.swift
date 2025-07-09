import SwiftUI

struct AircraftModelSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedCategory: AircraftCategory?
    let categories: [AircraftCategory]
    let onSelect: (AircraftCategory) -> Void

    init(selected: AircraftCategory?, categories: [AircraftCategory], onSelect: @escaping (AircraftCategory) -> Void) {
        self._selectedCategory = State(initialValue: selected)
        self.categories = categories
        self.onSelect = onSelect
    }

    var body: some View {
        NavigationStack {
            List(categories) { category in
                Button(action: {
                    onSelect(category)
                    dismiss()
                }) {
                    HStack {
                        AsyncImage(url: URL(string: category.aircraft_category_image_url)) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray.frame(width: 40, height: 40)
                        }
                        .frame(width: 40, height: 40)
                        Text(category.aircraft_category_name)
                            .font(.title3)
                            .padding(.leading, 8)
                        Spacer()
                        if selectedCategory?.id == category.id {
                            Image(systemName: "checkmark").foregroundColor(.accentColor)
                        }
                    }
                }
            }
            .navigationTitle("Aircraft Model")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
