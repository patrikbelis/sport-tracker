//
//  SportRecordFirebase.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Foundation
import FirebaseFirestore

struct SportRecordFirebase: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var location: String
    var duration: Int
}
