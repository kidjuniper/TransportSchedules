//
//  ScheduleManager.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation

protocol ScheduleManagerProtocol {
    func requestThreads(date: String,
                        transport: TransportType?,
                        completion: @escaping (Result<[Segment],
                                               YandexAPIError>) -> Void)
    func requestLastSearchData() -> [Segment]
}

final class ScheduleManager {
    // MARK: - Private Properties
    private let yandexAPIManager: YandexAPIManagerProtocol
    private let stationManager: StationListManagerProtocol
    private var lastSearchData: [Segment] = []
    
    // MARK: - initializer
    init(yandexAPIManager: YandexAPIManagerProtocol,
         stationManager: StationListManagerProtocol) {
        self.yandexAPIManager = yandexAPIManager
        self.stationManager = stationManager
    }
}

// MARK: - GenerationManagerProtocol extension
extension ScheduleManager: ScheduleManagerProtocol {
    func requestLastSearchData() -> [Segment] {
        lastSearchData
    }
    
    func requestThreads(date: String,
                        transport: TransportType?,
                        completion: @escaping (Result<[Segment],
                                               YandexAPIError>) -> Void) {
        let arrivingCity: Settlement = stationManager.returnArrivalCity()
        let departingCity: Settlement = stationManager.returnDepartureCity()
        
        yandexAPIManager.requestThreads(departureId: departingCity.codes.yandexCode,
                                        arrivalId: arrivingCity.codes.yandexCode,
                                        date: date,
                                        transport: transport) { result in
            switch result {
            case .success(let threadList):
                self.lastSearchData = threadList.segments
                completion(.success(threadList.segments))
            case .failure(_):
                completion(.failure(.failedRequest))
            }
        }
    }
}
