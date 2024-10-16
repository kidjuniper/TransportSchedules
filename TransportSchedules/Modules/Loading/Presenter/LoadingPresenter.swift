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
    private let stationListManager: StationListManagerProtocol
    
    init(coordinator: LoadingCoordinatorProtocol,
         viewController: LoadingViewInputProtocol,
         stationListManager: StationListManagerProtocol) {
        self.coordinator = coordinator
        self.viewController = viewController
        self.stationListManager = stationListManager
    }
    
    func animationDidFinish() {
        coordinator.finishFlow?()
        for i in stationListManager.returnCitiesList() {
            if i.title == K.departureCityPlaceholder {
                stationListManager.selectDepartureCity(city: i)
            }
            if i.title == K.arrivalCityPlaceholder {
                stationListManager.selectArrivalCity(city: i)
            }
        }
    }
    
    func viewDidLoad() {
        stationListManager.startLoading { result in
            if result {
                self.viewController.stopAnimation()
            }
            else {
                self.viewController.showError()
            }
        }
    }
}
