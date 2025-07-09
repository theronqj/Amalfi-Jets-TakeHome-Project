//
//  NotesSheet.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

/// A sheet view for adding or editing notes.
struct NotesSheet: View {
    /// The environment's dismiss action.
    @Environment(\.dismiss) private var dismiss
    /// Local state for the text editor.
    @State private var notesText: String
    /// A closure to be called when the notes are saved.
    let onSave: (String) -> Void
    /// A closure to be called when the sheet is cancelled.
    let onCancel: () -> Void

    /// Initializes the `NotesSheet`.
    /// - Parameters:
    ///   - initialNotes: The initial text for the notes.
    ///   - onSave: A closure to be called when the notes are saved.
    ///   - onCancel: A closure to be called when the sheet is cancelled.
    init(initialNotes: String, onSave: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        _notesText = State(initialValue: initialNotes)
        self.onSave = onSave
        self.onCancel = onCancel
    }

    /// The body of the view.
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Notes & Preferred Timing")
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

            TextEditor(text: $notesText)
                .frame(minHeight: 150)
                .padding(8)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding()

            Spacer()

            Button("Save Notes") {
                onSave(notesText)
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
