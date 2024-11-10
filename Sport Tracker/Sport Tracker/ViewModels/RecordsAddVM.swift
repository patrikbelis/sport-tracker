//
//  RecordsAddVM.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Foundation

class RecordEntryViewModel: ObservableObject {
    @Published var sportName: String = ""
    @Published var location: String = ""
    @Published var duration: Double = 0.0
    @Published var saveToLocal: Bool = true

    private var storageService: RecordDelegate?

    func saveRecord() {
        let record = SportRecord(
            name: sportName,
            location: location,
            duration: Int(duration),
            storageType: saveToLocal ? .local : .remote
        )

        storageService = saveToLocal ? RealmService() : FirebaseService()
        storageService?.add(record: record)
    }
}
