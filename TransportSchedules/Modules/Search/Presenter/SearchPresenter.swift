//
//  SearchPresenter.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

protocol SearchViewOutputProtocol: AnyObject,
                                  UICollectionViewDataSource {
    func viewDidLoad()
    func didTappedSearch()
    func didSelectedDate(date: Date)
    func didTappedArrivalStation()
    func didTappedDepartureStation()
    func didSelectedArrivalCity(city: Settlement)
    func didSelectedDepartureCity(city: Settlement)
    func swap()
    func didSelectedTransport(atIndex: IndexPath)
    func collectionView(sizeForItemAt indexPath: IndexPath) -> CGSize
}

final class SearchPresenter: NSObject {
    private weak var viewController: SearchViewInputProtocol?
    private let coordinator: SearchCoordinatorProtocol
    private let scheduleManager: ScheduleManagerProtocol
    private let stationListManager: StationListManagerProtocol
    private var arrivalCity: Settlement?
    private var departureCity: Settlement?
    
    init(viewController: SearchViewInputProtocol,
         coordinator: SearchCoordinatorProtocol,
         scheduleManager: ScheduleManagerProtocol,
         stationListManager: StationListManagerProtocol) {
        self.viewController = viewController
        self.coordinator = coordinator
        self.scheduleManager = scheduleManager
        self.stationListManager = stationListManager
    }
    
    // MARK: - Privat Properties
    private var transportData: [TransportCellData] = K.defaultTransportCellDataArray
    private var selectedDate: Date = Date()
    private var selectedTransportId = 0 {
        didSet {
            for index in transportData.indices {
                transportData[index].isSelected = (index == selectedTransportId)
            }
            transportData[selectedTransportId].isSelected = true
            viewController?.updateSelectedTransport()
        }
    }
    private var selectedTransport: TransportType?
}

// MARK: - TransportViewOutputProtocol
extension SearchPresenter: SearchViewOutputProtocol {
    func swap() {
        stationListManager.swapCities()
        setUpCities()
    }
    
    func didSelectedArrivalCity(city: Settlement) {
        viewController?.setArrivalCityTitle(city.title)
        arrivalCity = city
    }
    
    func didSelectedDepartureCity(city: Settlement) {
        viewController?.setDepartureCityTitle(city.title)
        departureCity = city
    }
    
    func didTappedArrivalStation() {
        coordinator.arrivingStationSelectionFlow?()
    }
    
    func didTappedDepartureStation() {
        coordinator.departureStationSelectionFlow?()
    }

    func collectionView(sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch transportData[indexPath.row].type {
        case .text:
            return CGSize(width: K.textTransportCollectionViewCellWidth(forNumberOfItems: transportData.count),
                          height: K.transportCollectionViewHeight)
        case .image:
            return CGSize(width: K.imageTransportCollectionViewCellWidth,
                          height: K.transportCollectionViewHeight)
        }
    }
    
    func didSelectedTransport(atIndex index: IndexPath) {
        let transports = TransportType.allCases
        selectedTransportId = index.row
        if selectedTransportId > 0 {
            selectedTransport = transports[selectedTransportId - 1]
        }
        else {
            selectedTransport = nil
        }
    }
    
    func didSelectedDate(date: Date) {
        selectedDate = date
    }
    
    func viewDidLoad() {
        setUpCities()
    }
    
    private func setUpCities() {
        viewController?.setArrivalCityTitle(stationListManager.returnArrivalCity().title)
        viewController?.setDepartureCityTitle(stationListManager.returnDepartureCity().title)
    }
    
    func didTappedSearch() {
        let isoFormatter = ISO8601DateFormatter()
        let iso8601String = isoFormatter.string(from: selectedDate)
        scheduleManager.requestThreads(date: iso8601String,
                                       transport: selectedTransport) { result in
            switch result {
            case .success(let data):
                self.coordinator.resultShowingFlow?()
                print(data.count)
            case .failure:
                return
            }
        }
    }
    
    // CollectionView related
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        transportData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return TransportCellsFactory.makeTransportCell(colletionView: collectionView,
                                                       indexPath: indexPath,
                                                       cellData: transportData[indexPath.row])
    }
}

