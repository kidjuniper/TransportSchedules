//
//  StationsFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

final class StationsFactory: StationsFactoryProtocol {
    func makeStationsViewController(withCoordinator coordinator: StationsCoordinatorProtocol,
                                   stationListManager: StationListManagerProtocol) -> StationsViewController {
        let viewController = StationsViewController()
        let presenter = StationsPresenter(stationsListManager: stationListManager,
                                          viewController: viewController,
                                          coordinator: coordinator)
        viewController.presenter = presenter
        return viewController
    }
}
