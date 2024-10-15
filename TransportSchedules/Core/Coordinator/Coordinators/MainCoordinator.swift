//
//  MainCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol MainFactoryProtocol {
    func makeMainViewController() -> MainViewController
}

protocol MainCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

final class MainCoordinator: BaseCoordinator,
                             MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    // MARK: - Private Properties
    fileprivate let factory: MainFactoryProtocol
    fileprivate let router: Routable
    
    // MARK: - Initializer
    init(router: Routable,
         factory: MainFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
}
