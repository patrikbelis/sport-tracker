//
//  RecordDelegate.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

import Combine

protocol RecordDelegate {
    func add(record: SportRecord)
    func fetch() -> AnyPublisher<[SportRecord], Error>
}
