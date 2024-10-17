//
//  YandexAPIRoute.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import Alamofire

enum YandexAPIRoute: ExtendedRequest {    
    case getStations
    case getThreads(departureId: String,
                    arrivalId: String,
                    date: String,
                    transport: TransportType?)
    
    var path: String {
        switch self {
        case .getStations:
            return "/stations_list/?&lang=ru_RU&format=json"
        case .getThreads(departureId: let departureId,
                         arrivalId: let arrivalId,
                         date: let date,
                         transport: let transport):
            if let transport = transport {
                return "/search/?&format=json&from=\(departureId)&to=\(arrivalId)&transport_types=\(transport)&lang=ru_RU&page=1&date=\(date)"
            }
            else {
                return "/search/?&format=json&from=\(departureId)&to=\(arrivalId)&lang=ru_RU&page=1&date=\(date)"
            }
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getStations:
            return .get
        case .getThreads:
            return .get
        }
    }
}
