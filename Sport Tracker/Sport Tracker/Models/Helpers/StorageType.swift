//
//  StorageType.swift
//  Sport Tracker
//
//  Created by Patrik on 10/11/2024.
//

public enum StorageType: String, CaseIterable, Identifiable {
    case all, local, remote

    public var id: String { self.rawValue }
}
