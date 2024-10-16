//
//  StationListManager.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

protocol StationListManagerProtocol {
    func selectArrivalCity(city: Settlement)
    func selectDepartureCity(city: Settlement)
    func returnCitiesList() -> [Settlement]
    func returnArrivalCity() -> Settlement
    func returnDepartureCity() -> Settlement
    func returnStationsForArrival() -> [Station]
    func returnStationsForDeparture() -> [Station]
    func startLoading(completion: @escaping (Bool) -> Void)
}

final class StationListManager {
    // MARK: - Private Properties
    private let yandexAPIManager: YandexAPIManagerProtocol
    private var lastFindedCities: [Settlement] = []
    private var arrival: Settlement = Settlement(title: "Москва",
                                                 codes: CountryCodes(),
                                                 stations: [])
    private var departure: Settlement = Settlement(title: "Нижний Новгород",
                                                   codes: CountryCodes(),
                                                   stations: [])
    
    // MARK: - initializer
    init(yandexAPIManager: YandexAPIManagerProtocol) {
        self.yandexAPIManager = yandexAPIManager
    }
}

// MARK: - GenerationManagerProtocol extension
extension StationListManager: StationListManagerProtocol {
    func returnArrivalCity() -> Settlement {
        return arrival
    }
    
    func returnDepartureCity() -> Settlement {
        return departure
    }
    
    func returnCitiesList() -> [Settlement] {
        lastFindedCities
    }
    
    func selectArrivalCity(city: Settlement) {
        arrival = city
    }
    
    func selectDepartureCity(city: Settlement) {
        departure = city
    }
    
    func returnStationsForArrival() -> [Station] {
        arrival.stations
    }
    
    func returnStationsForDeparture() -> [Station] {
        departure.stations
    }
    
    func startLoading(completion: @escaping (Bool) -> Void) {
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
                    lastFindedCities.append(k)
                }
            }
        }
    }
}
