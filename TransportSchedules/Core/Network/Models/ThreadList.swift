//
//  RoutesList.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation

// MARK: - Welcome
struct RoutesList: Codable {
    let search: Search
    let segments: [Segment]
    let pagination: Pagination

    enum CodingKeys: String,
                     CodingKey {
        case search,
             segments
        case pagination
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let total,
        limit,
        offset: Int
}

// MARK: - Search
struct Search: Codable {
    let from,
        to: SearchFrom
    let date: String
}

// MARK: - SearchFrom
struct SearchFrom: Codable {
    let type,
        title,
        shortTitle,
        popularTitle: String
    let code: String

    enum CodingKeys: String,
                     CodingKey {
        case type,
             title
        case shortTitle = "short_title"
        case popularTitle = "popular_title"
        case code
    }
}

// MARK: - Segment
struct Segment: Codable {
    let thread: Thread
    let stops: String
    let from, to: SegmentFrom
    let departurePlatform,
        arrivalPlatform: String
    let duration: Int
    let hasTransfers: Bool
    let departure,
        arrival: Date
    let startDate: String

    enum CodingKeys: String, CodingKey {
        case thread, stops, from, to
        case departurePlatform = "departure_platform"
        case arrivalPlatform = "arrival_platform"
        case duration
        case hasTransfers = "has_transfers"
        case departure, arrival
        case startDate = "start_date"
    }
}

// MARK: - SegmentFrom
struct SegmentFrom: Codable {
    let type: TypeEnum
    let title: String
    let shortTitle: String?
    let popularTitle,
        code: String
    let transportType: TransportType

    enum CodingKeys: String, CodingKey {
        case type,
             title
        case shortTitle = "short_title"
        case popularTitle = "popular_title"
        case code
        case transportType = "transport_type"
    }
}

enum TransportType: String,
                    Codable {
    case plane = "самолет"
    case train = "поезд"
    case suburban = "электричка"
    case bus = "автобус"
    case water = "водный транспорт"
    case helicopter = "вертолет"
}

enum TypeEnum: String,
               Codable {
    case station = "station"
}

// MARK: - Thread
struct Thread: Codable {
    let number,
        title,
        shortTitle: String
    let transportType: TransportType
    let carrier: Carrier?
    let uid: String
    let vehicle: String

    enum CodingKeys: String, CodingKey {
        case number,
             title
        case shortTitle = "short_title"
        case transportType = "transport_type"
        case carrier,
             uid,
             vehicle
    }
}

// MARK: - Carrier
struct Carrier: Codable {
    let code: Int
    let title: String
    let url: String
    let contacts,
        phone: String

    enum CodingKeys: String,
                     CodingKey {
        case code,
             title,
             url,
             contacts,
             phone
    }
}
