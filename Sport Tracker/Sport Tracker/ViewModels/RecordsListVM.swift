//
//  RecordsListVM.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Foundation
import Combine

class RecordsListViewModel: ObservableObject {
    @Published var selectedFilter: StorageType = .all
    @Published var records: [SportRecord] = []

    private let firebaseService: FirebaseService
    private let realmService: RealmService
    private var dBag: Set<AnyCancellable> = []

    init(firebaseService: FirebaseService, realmService: RealmService) {
        self.firebaseService = firebaseService
        self.realmService = realmService
        loadRecords()
    }

    var filteredRecords: [SportRecord] {
        switch selectedFilter {
        case .all:
            return records
        case .local:
            return records.filter { $0.storageType == .local }
        case .remote:
            return records.filter { $0.storageType == .remote }
        }
    }

    func loadRecords() {
        Publishers.Zip(firebaseService.fetch(), realmService.fetch())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to load records: \(error)")
                }
            }, receiveValue: { [weak self] firebaseRecords, realmRecords in
                self?.records = firebaseRecords + realmRecords
            })
            .store(in: &dBag)
    }
}
