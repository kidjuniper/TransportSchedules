//
//  TransportCellData.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 18.10.2024.
//

import Foundation

struct TransportCellData {
    var type: TransportCellType
    var isSelected: Bool
    var contentName: String
}

enum TransportCellType {
    case text
    case image
}
