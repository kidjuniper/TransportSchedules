//
//  StationsFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

final class StationsFactory: StationsFactoryProtocol {
    func makeStationsViewController(withCoordinator coordinator: StationsCoordinatorProtocol,
                                   stationListManager: StationListManagerProtocol,
                                    forArrival: Bool) -> StationsViewController {
        let viewController = StationsViewController()
        print(forArrival)
        let presenter = StationsPresenter(stationsListManager: stationListManager,
                                          isArrival: forArrival)
//        viewController.presenter = StationsViewController(coordinator: coordinator,
//                                                    viewController: viewController,
//                                                    stationListManager: stationListManager)
        return viewController
    }
}
