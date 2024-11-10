//
//  SportRecord.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Foundation
import RealmSwift

class SportRecordRealm: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var duration: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}
