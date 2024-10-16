//
//  StationsList.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

// MARK: - StationsList
struct StationList: Codable {
    @DefaultEmptyArray
    var countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    @DefaultEmptyArray
    var regions: [Region]
    @DefaultEmptyEntity
    var codes: CountryCodes
    @DefaultEmptyString
    var title: String
}

// MARK: - CountryCodes
struct CountryCodes: Codable,
                     DefaultInitializable {
    // MARK: - Default Initializer
    init() {
        self.yandexCode = ""
    }
    
    @DefaultEmptyString
    var yandexCode: String

    enum CodingKeys: String, CodingKey {
        case yandexCode = "yandex_code"
    }
}

// MARK: - Region
struct Region: Codable {
    @DefaultEmptyArray
    var settlements: [Settlement]
    @DefaultEmptyEntity
    var codes: CountryCodes
    @DefaultEmptyString
    var title: String
}

// MARK: - Settlement
struct Settlement: Codable {
    @DefaultEmptyString
    var title: String
    @DefaultEmptyEntity
    var codes: CountryCodes
    @DefaultEmptyArray
    var stations: [Station]
}

// MARK: - Station
struct Station: Codable {
    @DefaultEmptyString
    var direction: String
    @DefaultEmptyEntity
    var codes: StationCodes
    @DefaultEmptyString
    var stationType: String
    @DefaultEmptyString
    var title: String
    @DefaultDouble
    var longitude: Double
    @DefaultEmptyString
    var transportType: String
    @DefaultDouble
    var latitude: Double

    enum CodingKeys: String,
                     CodingKey {
        case direction, codes
        case stationType = "station_type"
        case title, longitude
        case transportType = "transport_type"
        case latitude
    }
}

// MARK: - StationCodes
struct StationCodes: Codable,
                     DefaultInitializable {
    // MARK: - Default Initializer
    init() {
        yandexCode = ""
        esrCode = ""
    }
    
    @DefaultEmptyString
    var yandexCode: String
    @DefaultEmptyString
    var esrCode: String

    enum CodingKeys: String,
                     CodingKey {
        case yandexCode = "yandex_code"
        case esrCode = "esr_code"
    }
}
