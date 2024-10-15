//
//  LoadingCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol LoadingFactoryProtocol {
    func makeLoadingViewController(withCoordinator: LoadingCoordinatorProtocol) -> LoadingViewController
}

protocol LoadingCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

typealias LoadingCoordinatorProtocol = BaseCoordinator & SearchCoordinatorOutput

final class LoadingCoordinator: LoadingCoordinatorProtocol {
    var finishFlow: CompletionBlock?
    
    // MARK: - Private Properties
    fileprivate let factory: LoadingFactoryProtocol
    fileprivate let router: Routable
    
    // MARK: - Initializer
    init(router: Routable,
         factory: LoadingFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
    // MARK: - Search Logic
    override func start() {
        let loadingViewController = factory.makeLoadingViewController(withCoordinator: self)
        router.setRootModule(loadingViewController,
                             hideBar: true)
    }
}
