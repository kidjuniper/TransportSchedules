//
//  AppCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router: Routable
    private let stationListManager: StationListManagerProtocol
    
    // MARK: - Initializer
    init(router: Routable,
         factory: CoordinatorFactoryProtocol,
         stationListManager: StationListManagerProtocol) {
        self.router = router
        self.factory = factory
        self.stationListManager = stationListManager
    }
    
    override func start() {
        showLoadingScreen()
    }
}

private extension AppCoordinator {
    func showLoadingScreen() {
        let coordinator = factory.makeLoadingViewController(router: router,
                                                            stationManager: stationListManager)
        addChildCoordinator(coordinator)
        
        coordinator.finishFlow = { [weak self,
                                    weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.removeChildCoordinator(coordinator)
            self.showSearchScreen()
        }
        
        coordinator.start()
    }
    
    func showSearchScreen() {
        let coordinator = factory.makeSearchCoordinator(router: router)
        addChildCoordinator(coordinator)
        
        coordinator.arrivingStationSelectionFlow = { [weak self] in
            guard let self = self else { return }
            self.showStationSelection(forArrival: true)
        }
        
        coordinator.departureStationSelectionFlow = { [weak self] in
            guard let self = self else { return }
            self.showStationSelection(forArrival: false)
        }
        
        coordinator.finishFlow = { [weak self,
                                    weak coordinator] in
            guard let self = self,
                  let coordinator = coordinator else { return }
            self.removeChildCoordinator(coordinator)
        }
        
        coordinator.start()
    }
    
    func showStationSelection(forArrival: Bool) {
        let coordinator = factory.makeStationsCoordinator(router: router,
                                                          stationManager: stationListManager)
        addChildCoordinator(coordinator)
        
        coordinator.finishFlow = { [weak self,
                                    weak coordinator] city in
            guard let self = self, let coordinator = coordinator else { return }
            if let searchViewController = self.router.root as? SearchViewController {
                if forArrival {
                    searchViewController.presenter?.didSelectedArrivalCity(city: city)
                } else {
                    searchViewController.presenter?.didSelectedDepartureCity(city: city)
                }
                router.dismissModule(animated: true) {}
            }
            self.removeChildCoordinator(coordinator)
        }
        
        coordinator.start()
    }
}
