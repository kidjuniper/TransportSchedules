//
//  ThreadList.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation

// MARK: - Welcome
struct ThreadList: Codable {
    @DefaultEmptyEntity
    var search: Search
    @DefaultEmptyArray
    var segments: [Segment]
    @DefaultEmptyEntity
    var pagination: Pagination

    enum CodingKeys: String,
                     CodingKey {
        case search,
             segments
        case pagination
    }
}

// MARK: - Pagination
struct Pagination: Codable,
                   DefaultInitializable {
    init() {
        total = 0
        limit = 0
        offset = 0
    }
    
    @DefaultInt
    var total: Int
    @DefaultInt
    var limit: Int
    @DefaultInt
    var offset: Int
}

// MARK: - Search
struct Search: Codable,
               DefaultInitializable {
    @DefaultEmptyEntity
    var from: SearchFrom
    @DefaultEmptyEntity
    var to: SearchFrom
    @DefaultEmptyString
    var date: String
    
    init() {
        date = ""
        from = SearchFrom()
        to = SearchFrom()
    }
}

// MARK: - SearchFrom
struct SearchFrom: Codable,
                   DefaultInitializable {
    init() {
        type = ""
        title = ""
        shortTitle = ""
        popularTitle = ""
        code = ""
    }
    
    @DefaultEmptyString
    var type: String
    @DefaultEmptyString
    var title: String
    @DefaultEmptyString
    var shortTitle: String
    @DefaultEmptyString
    var popularTitle: String
    @DefaultEmptyString
    var code: String

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
    @DefaultEmptyString
    var stops: String
    var from: SegmentFrom
    var to: SegmentFrom
    @DefaultEmptyString
    var departurePlatform: String
    @DefaultEmptyString
    var arrivalPlatform: String
    @DefaultInt
    var duration: Int
    let departure,
        arrival: String
    @DefaultEmptyString
    var startDate: String

    enum CodingKeys: String, CodingKey {
        case thread, stops, from, to
        case departurePlatform = "departure_platform"
        case arrivalPlatform = "arrival_platform"
        case duration
        case departure, arrival
        case startDate = "start_date"
    }
}

// MARK: - SegmentFrom
struct SegmentFrom: Codable {
    let type: TypeEnum
    @DefaultEmptyString
    var title: String
    @DefaultEmptyString
    var shortTitle: String
    @DefaultEmptyString
    var popularTitle: String
    @DefaultEmptyString
    var code: String
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

// MARK: - TransportType
enum TransportType: String,
                    Codable,
                    CaseIterable {
    case plane
    case train
    case suburban
    case bus
    case water
    case helicopter
}

// MARK: - TypeEnum
enum TypeEnum: String,
               Codable {
    case station = "station"
}

// MARK: - Thread
struct Thread: Codable {
    @DefaultEmptyString
    var number: String
    @DefaultEmptyString
    var title: String
    @DefaultEmptyString
    var shortTitle: String
    let transportType: TransportType
    let carrier: Carrier?
    @DefaultEmptyString
    var vehicle: String
    let transportSubtype: TransportSubtype

    enum CodingKeys: String, CodingKey {
        case number,
             title
        case shortTitle = "short_title"
        case transportType = "transport_type"
        case transportSubtype = "transport_subtype"
        case carrier,
             vehicle
    }
}

// MARK: - TransportSubtype
struct TransportSubtype: Codable {
    @DefaultEmptyString
    var title: String
}

// MARK: - Carrier
struct Carrier: Codable {
    let title: String
}
