//
//  RecordsAddView.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import SwiftUI

struct RecordsAddView: View {
    @StateObject private var viewModel = RecordEntryViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Sport Name", text: $viewModel.sportName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("Location", text: $viewModel.location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Text("Duration:")
                    Slider(value: $viewModel.duration, in: 0...180, step: 5)
                    Text("\(Int(viewModel.duration)) min")
                }
                .padding(.horizontal)

                Toggle("Save to Local Database", isOn: $viewModel.saveToLocal)
                    .padding(.horizontal)

                Button(action: {
                    viewModel.saveRecord()
                    dismiss()
                }) {
                    Text("Save Record")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(viewModel.sportName.isEmpty || viewModel.location.isEmpty)

                Spacer()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Add record")
    }
}
