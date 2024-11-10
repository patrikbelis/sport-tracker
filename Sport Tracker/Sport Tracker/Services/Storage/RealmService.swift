//
//  RealmService.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Combine
import RealmSwift

enum DatabaseError: Error {
    case realmError
    case firebaseError
}

final class RealmService: RecordDelegate {
    private let realm = try! Realm()

    func add(record: SportRecord) {
        let realmRecord = SportRecordRealm()
        realmRecord.id = record.id.uuidString
        realmRecord.name = record.name
        realmRecord.location = record.location
        realmRecord.duration = record.duration

        do {
            try realm.write {
                realm.add(realmRecord)
            }
        } catch {
            print("Failed to add record: \(error.localizedDescription)")
        }
    }

    func fetch() -> AnyPublisher<[SportRecord], Error> {
        return Future { [weak self] promise in
            guard let self else { promise(.failure(DatabaseError.realmError)); return }
            let realmRecords = realm.objects(SportRecordRealm.self)

            let records = realmRecords.map { realmRecord in
                SportRecord(name: realmRecord.name,
                            location: realmRecord.location,
                            duration: realmRecord.duration,
                            storageType: .local)
            }

            promise(.success(Array(records)))
        }
        .eraseToAnyPublisher()
    }
}
