//
//  SearchFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class SearchFactory: SearchFactoryProtocol {
    func makeSearchViewController(withCoordinator coordinator: SearchCoordinatorProtocol,
                                  scheduleManager: ScheduleManagerProtocol,
                                  stationListManager: StationListManagerProtocol) -> SearchViewController {
        let viewController = SearchViewController()
        viewController.presenter = SearchPresenter(viewController: viewController,
                                                   coordinator: coordinator,
                                                   scheduleManager: scheduleManager,
                                                   stationListManager: stationListManager)
        return viewController
    }
}
