//
//  CoordinatorFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeResultViewController(router: any Routable,
                                  scheduleManager: any ScheduleManagerProtocol) -> ResultCoordinator {
        let coordinator = ResultCoordinator(router: router,
                                            factory: ResultFactory(),
                                            scheduleManager: scheduleManager)
        return coordinator
    }
    
    func makeLoadingViewController(router: Routable,
                                   stationManager: StationListManagerProtocol) -> LoadingCoordinator {
        let coordinator = LoadingCoordinator(router: router,
                                             factory: LoadingFactory(),
                                             stationManager: stationManager)
        return coordinator
    }
    
    func makeSearchCoordinator(router: Routable,
                               scheduleManager: ScheduleManagerProtocol,
                               stationListManager: StationListManagerProtocol) -> SearchCoordinator {
        let coordinator = SearchCoordinator(router: router,
                                            factory: SearchFactory(),
                                            scheduleManager: scheduleManager,
                                            stationListManager: stationListManager)
        return coordinator
    }
    
    func makeStationsCoordinator(router: Routable,
                                 stationManager: StationListManagerProtocol) -> StationsCoordinator {
        let coordinator = StationsCoordinator(router: router,
                                              factory: StationsFactory(),
                                              stationManager: stationManager)
        return coordinator
    }
}
