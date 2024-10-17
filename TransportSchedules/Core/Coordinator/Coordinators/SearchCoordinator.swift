//
//  SearchCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol SearchFactoryProtocol {
    func makeSearchViewController(withCoordinator coordinator: SearchCoordinatorProtocol,
                                  scheduleManager: ScheduleManagerProtocol,
                                  stationListManager: StationListManagerProtocol) -> SearchViewController
}

protocol SearchCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
    var resultShowingFlow: CompletionBlock? { get set }
    var arrivingStationSelectionFlow: CompletionBlock? { get set }
    var departureStationSelectionFlow: CompletionBlock? { get set }
}

typealias SearchCoordinatorProtocol = BaseCoordinator & SearchCoordinatorOutput

final class SearchCoordinator: SearchCoordinatorProtocol {
    var resultShowingFlow: CompletionBlock?
    
    var arrivingStationSelectionFlow: CompletionBlock?
    var departureStationSelectionFlow: CompletionBlock?
    
    var finishFlow: CompletionBlock?
    
    // MARK: - Private Properties
    fileprivate let factory: SearchFactoryProtocol
    fileprivate let router: Routable
    fileprivate let scheduleManager: ScheduleManagerProtocol
    fileprivate let stationListManager: StationListManagerProtocol
    
    // MARK: - Initializer
    init(router: Routable,
         factory: SearchFactoryProtocol,
         scheduleManager: ScheduleManagerProtocol,
         stationListManager: StationListManagerProtocol) {
        self.router = router
        self.factory = factory
        self.scheduleManager = scheduleManager
        self.stationListManager = stationListManager
    }
    
    override func start() {
        let stationSelectionVC = factory.makeSearchViewController(withCoordinator: self,
                                                                  scheduleManager: scheduleManager,
                                                                  stationListManager: stationListManager)
        router.setRootModule(stationSelectionVC,
                             hideBar: true)
    }
}
