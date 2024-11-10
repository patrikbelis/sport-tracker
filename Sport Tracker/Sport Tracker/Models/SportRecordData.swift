//
//  SportRecordData.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Foundation

struct SportRecord: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let duration: Int
    let storageType: StorageType
}
