//
//  CitiesCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

protocol StationsFactoryProtocol {
    func makeStationsViewController(withCoordinator coordinator: StationsCoordinatorProtocol,
                                   stationListManager: StationListManagerProtocol) -> StationsViewController
}

protocol StationsCoordinatorOutput: AnyObject {
    var finishFlow: ((Settlement) -> Void)? { get set }
}

typealias StationsCoordinatorProtocol = BaseCoordinator & StationsCoordinatorOutput

final class StationsCoordinator: StationsCoordinatorProtocol {
    var finishFlow: ((Settlement) -> Void)?
    
    // MARK: - Properties
    private let router: Routable
    private let factory: StationsFactoryProtocol
    private let stationManager: StationListManagerProtocol

    init(router: Routable,
         factory: StationsFactoryProtocol,
         stationManager: StationListManagerProtocol) {
        self.router = router
        self.factory = factory
        self.stationManager = stationManager
    }

    override func start() {
        let stationSelectionVC = factory.makeStationsViewController(withCoordinator: self,
                                                                    stationListManager: stationManager)
        router.presentModule(stationSelectionVC,
                             animated: true,
                             completion: nil)
    }
}
