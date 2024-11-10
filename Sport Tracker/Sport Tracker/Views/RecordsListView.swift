//
//  ContentView.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import SwiftUI

struct RecordsListView: View {
    @StateObject private var viewModel: RecordsListViewModel

    init() {
        _viewModel = StateObject(wrappedValue: RecordsListViewModel(firebaseService: FirebaseService(), realmService: RealmService()))
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    Text("All").tag(StorageType.all)
                    Text("Local").tag(StorageType.local)
                    Text("Remote").tag(StorageType.remote)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(viewModel.filteredRecords) { record in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(record.name)
                                .font(.headline)
                            Text(record.location)
                                .font(.subheadline)
                            Text("Duration: \(record.duration) min")
                                .font(.subheadline)
                        }
                        Spacer()
                        Circle()
                            .fill(record.storageType == .local ? Color.green : Color.orange)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .navigationTitle("Record List")
            .navigationBarItems(trailing: NavigationLink(destination: RecordsAddView()) {
                Image(systemName: "plus")
                    .font(.title2)
            })
            .onAppear {
                viewModel.loadRecords()
            }
        }
    }
}
