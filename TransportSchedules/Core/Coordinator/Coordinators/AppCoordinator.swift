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
    
    // MARK: - Initializer
    init(router: Routable,
         factory: CoordinatorFactoryProtocol) {
        self.router  = router
        self.factory = factory
    }
    
    override func start() {
        showLoadingScreen()
    }
}

private extension AppCoordinator {
    func showLoadingScreen() {
        let coordinator = factory.makeLoadingViewController(router: router)
        coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.showSearchScreen()
        }
        coordinator.start()
    }
    
    func showSearchScreen() {
        let coordinator = factory.makeSearchCoordinator(router: router)
        coordinator.start()
    }
}
