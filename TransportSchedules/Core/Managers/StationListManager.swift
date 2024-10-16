//
//  StationListManager.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

protocol StationListManagerProtocol {
    func returnStations() -> [Station]
    func startStationLoading(completion: @escaping (Bool) -> Void)
}

final class StationListManager {
    // MARK: - Private Properties
    private let yandexAPIManager: YandexAPIManagerProtocol
    private var lastFindedStations: [Station] = []
    
    // MARK: - initializer
    init(yandexAPIManager: YandexAPIManagerProtocol) {
        self.yandexAPIManager = yandexAPIManager
    }
}

// MARK: - GenerationManagerProtocol extension
extension StationListManager: StationListManagerProtocol {
    func returnStations() -> [Station] {
        return lastFindedStations
    }
    
    func startStationLoading(completion: @escaping (Bool) -> Void) {
        yandexAPIManager.requestStations { result in
            switch result {
            case .success(let data):
                self.processData(data: data)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    private func processData(data: StationList) {
        for i in data.countries {
            for j in i.regions {
                for k in j.settlements {
                    for s in k.stations {
                        lastFindedStations.append(s)
                    }
                }
            }
        }
    }
}
