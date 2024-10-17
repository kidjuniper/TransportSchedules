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
    func makeSearchCoordinator(router: Routable,
                              scheduleManager: ScheduleManagerProtocol,
                              stationListManager: StationListManagerProtocol) -> SearchCoordinator
    func makeStationsCoordinator(router: Routable,
                                 stationManager: StationListManagerProtocol) -> StationsCoordinator
    func makeResultViewController(router: Routable,
                                  scheduleManager: ScheduleManagerProtocol) -> ResultCoordinator
}
