//
//  ResultFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation

final class ResultFactory: ResultFactoryProtocol {
    func makeResultViewController(withCoordinator coordinator: any ResultCoordinatorProtocol,
                                  scheduleManager: any ScheduleManagerProtocol) -> ResultViewController {
        let viewController = ResultViewController()
        viewController.presenter = ResultPresenter(scheduleManager: scheduleManager,
                                                   viewController: viewController)
        return viewController
    }
}
