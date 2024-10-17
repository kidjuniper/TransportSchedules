//
//  LoadingCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol LoadingFactoryProtocol {
    func makeLoadingViewController(withCoordinator coordinator: LoadingCoordinatorProtocol,
                                   stationListManager: StationListManagerProtocol) -> LoadingViewController
}

protocol LoadingCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

typealias LoadingCoordinatorProtocol = BaseCoordinator & LoadingCoordinatorOutput

final class LoadingCoordinator: LoadingCoordinatorProtocol {
    var finishFlow: CompletionBlock?
    
    // MARK: - Private Properties
    fileprivate let factory: LoadingFactoryProtocol
    fileprivate let router: Routable
    private let stationManager: StationListManagerProtocol
    
    // MARK: - Initializer
    init(router: Routable,
         factory: LoadingFactoryProtocol,
         stationManager: StationListManagerProtocol) {
        self.router = router
        self.factory = factory
        self.stationManager = stationManager
    }
    
    // MARK: - Search Logic
    override func start() {
        let loadingViewController = factory.makeLoadingViewController(withCoordinator: self,
                                                                      stationListManager: stationManager)
        router.setRootModule(loadingViewController,
                             hideBar: true)
    }
}
