//
//  CoordinatorFactoryProtocol.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeLoadingViewController(router: Routable,
                                   stationManager: StationListManagerProtocol) -> LoadingCoordinator
    func makeSearchCoordinator(router: Routable) -> SearchCoordinator
}
