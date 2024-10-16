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
    
    var path: String {
        switch self {
        case .getStations:
            return "/stations_list/?&lang=ru_RU&format=json"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getStations:
            return .get
        }
    }
}
