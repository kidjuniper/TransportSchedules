//
//  ResultCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation

protocol ResultFactoryProtocol {
    func makeResultViewController(withCoordinator coordinator: ResultCoordinatorProtocol,
                                  scheduleManager: ScheduleManagerProtocol) -> ResultViewController
}

protocol ResultCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

typealias ResultCoordinatorProtocol = BaseCoordinator & ResultCoordinatorOutput

final class ResultCoordinator: ResultCoordinatorProtocol {
    var finishFlow: CompletionBlock?
    
    // MARK: - Private Properties
    fileprivate let factory: ResultFactoryProtocol
    fileprivate let router: Routable
    fileprivate let scheduleManager: ScheduleManagerProtocol
    
    // MARK: - Initializer
    init(router: Routable,
         factory: ResultFactoryProtocol,
         scheduleManager: ScheduleManagerProtocol) {
        self.router = router
        self.factory = factory
        self.scheduleManager = scheduleManager
    }
    
    override func start() {
        let resultSelectionVC = factory.makeResultViewController(withCoordinator: self,
                                                                  scheduleManager: scheduleManager)
        router.presentModule(resultSelectionVC,
                             animated: true,
                             completion: {})
    }
}
