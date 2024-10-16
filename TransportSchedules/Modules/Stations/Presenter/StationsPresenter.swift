//
//  StationsPresenter.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation

protocol StationsPresenterProtocol {
    
}

final class StationsPresenter: StationsPresenterProtocol {
    private let stationsListManager: StationListManagerProtocol
    private let isArrival: Bool
    
    init(stationsListManager: StationListManagerProtocol,
         isArrival: Bool) {
        self.stationsListManager = stationsListManager
        self.isArrival = isArrival
        if isArrival {
            print(stationsListManager.returnArrivalCity().title)
        }
        else {
            print(stationsListManager.returnDepartureCity().title)
        }
    }
}
