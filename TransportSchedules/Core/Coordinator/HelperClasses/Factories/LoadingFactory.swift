//
//  LoadingFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class LoadingFactory: LoadingFactoryProtocol {
    func makeLoadingViewController(withCoordinator coordinator: LoadingCoordinatorProtocol,
                                   stationListManager: StationListManagerProtocol) -> LoadingViewController {
        let viewController = LoadingViewController()
        viewController.presenter = LoadingPresenter(coordinator: coordinator,
                                                    viewController: viewController,
                                                    stationListManager: stationListManager)
        return viewController
    }
}
