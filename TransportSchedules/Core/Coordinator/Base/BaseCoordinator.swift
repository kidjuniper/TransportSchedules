//
//  BaseCoordinator.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

class BaseCoordinator: Coordinatable {
    var childCoordinators: [BaseCoordinator] = []

    func start() {}

    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
