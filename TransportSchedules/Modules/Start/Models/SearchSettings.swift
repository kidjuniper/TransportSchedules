//
//  SearchSettings.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

struct SearchSettings {
    let transport: Transport
    let date: Date
}

enum Transport {
    case bus
    case train
}
