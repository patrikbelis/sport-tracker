//
//  FirebaseService.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Combine
import FirebaseFirestore

final class FirebaseService: RecordDelegate {
    private let db = Firestore.firestore()

    func add(record: SportRecord) {
        let firebaseRecord = SportRecordFirebase(id: record.id.uuidString,
                                                 name: record.name,
                                                 location: record.location,
                                                 duration: record.duration)

        do {
            guard let id = firebaseRecord.id else { throw DatabaseError.firebaseError }
            _ = try db.collection("sportRecords").document(id).setData(from: firebaseRecord)
        } catch let error {
            print("Error writing record to Firestore: \(error.localizedDescription)")
        }
    }

    func fetch() -> AnyPublisher<[SportRecord], Error> {
        return Future { promise in
            let db = Firestore.firestore()
            let collectionRef = db.collection("sportRecords")

            collectionRef.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let records = snapshot?.documents.compactMap { doc -> SportRecord? in
                        let data = doc.data()
                        guard let name = data["name"] as? String,
                              let location = data["location"] as? String,
                              let duration = data["duration"] as? Int else {
                            return nil
                        }
                        return SportRecord(name: name,
                                           location: location,
                                           duration: duration,
                                           storageType: .remote)
                    } ?? []
                    promise(.success(records))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
