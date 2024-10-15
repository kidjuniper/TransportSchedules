//
//  LoadingCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol LoadingFactoryProtocol {
    func makeLoadingViewController() -> LoadingViewController
}

protocol LoadingCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}

final class LoadingCoordinator: BaseCoordinator,
                                MainCoordinatorOutput {
    
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
    
    // MARK: - Start Logic
    override func start() {
        let loadingViewController = factory.makeLoadingViewController()
        router.setRootModule(loadingViewController,
                             hideBar: true)
        simulateLoading { [weak self] in
            self?.finishFlow?()
        }
    }
    
    private func simulateLoading(completion: @escaping CompletionBlock) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion()
        }
    }
}
