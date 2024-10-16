//
//  CitiesCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation

protocol StationsFactoryProtocol {
    func makeStationsViewController(withCoordinator coordinator: StationsCoordinatorProtocol,
                                   stationListManager: StationListManagerProtocol,
                                    forArrival: Bool) -> StationsViewController
}

protocol StationsCoordinatorOutput: AnyObject {
    var finishFlow: ((Station) -> Void)? { get set }
}

typealias StationsCoordinatorProtocol = BaseCoordinator & StationsCoordinatorOutput

final class StationsCoordinator: StationsCoordinatorProtocol {
    var finishFlow: ((Station) -> Void)?
    
    // MARK: - Properties
    private let router: Routable
    private let factory: StationsFactoryProtocol
    private let stationManager: StationListManagerProtocol
    private let forArrival: Bool

    init(router: Routable,
         factory: StationsFactoryProtocol,
         stationManager: StationListManagerProtocol,
         forArrival: Bool) {
        self.router = router
        self.factory = factory
        self.stationManager = stationManager
        self.forArrival = forArrival
    }

    override func start() {
        let stationSelectionVC = factory.makeStationsViewController(withCoordinator: self,
                                                                    stationListManager: stationManager,
                                                                    forArrival: forArrival)
        router.presentModule(stationSelectionVC,
                             animated: true,
                             completion: nil)
    }
}
