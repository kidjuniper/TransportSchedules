//
//  SearchCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol SearchFactoryProtocol {
    func makeSearchViewController(withCoordinator coordinator: SearchCoordinatorProtocol) -> SearchViewController
}

protocol SearchCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
    var arrivingStationSelectionFlow: CompletionBlock? { get set }
    var departureStationSelectionFlow: CompletionBlock? { get set }
}

typealias SearchCoordinatorProtocol = BaseCoordinator & SearchCoordinatorOutput

final class SearchCoordinator: SearchCoordinatorProtocol {
    var finishFlow: CompletionBlock?
    
    var arrivingStationSelectionFlow: CompletionBlock?
    var departureStationSelectionFlow: CompletionBlock?
    
    // MARK: - Private Properties
    fileprivate let factory: SearchFactoryProtocol
    fileprivate let router: Routable
    
    // MARK: - Initializer
    init(router: Routable,
         factory: SearchFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        let stationSelectionVC = factory.makeSearchViewController(withCoordinator: self)
        router.setRootModule(stationSelectionVC,
                             hideBar: true)
    }
}
