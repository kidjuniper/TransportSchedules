//
//  LoadingPresenter.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

protocol LoadingViewOutputProtocol: AnyObject {
    func animationDidFinish()
    func viewDidLoad()
}

final class LoadingPresenter: LoadingViewOutputProtocol {
    private var viewController: LoadingViewInputProtocol
    private let coordinator: LoadingCoordinatorProtocol
    
    init(coordinator: LoadingCoordinatorProtocol,
         viewController: LoadingViewInputProtocol) {
        self.coordinator = coordinator
        self.viewController = viewController
    }
    
    func animationDidFinish() {
        coordinator.finishFlow?()
    }
    
    func viewDidLoad() {
        viewController.SearchAnimation()
    }
}
