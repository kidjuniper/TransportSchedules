//
//  CoordinatorFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeLoadingViewController(router: Routable) -> LoadingCoordinator {
        let coordinator = LoadingCoordinator(router: router,
                                             factory: LoadingFactory())
        return coordinator
    }
    
    func makeMainCoordinator(router: Routable) -> MainCoordinator {
        let coordinator = MainCoordinator(router: router,
                                          factory: MainFactory())
        return coordinator
    }
}
