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
    func didSelectedArrivalStation(station: Station)
    func didSelectedDepartureStation(station: Station)
    func didSelectedArrivalCity(city: Settlement)
    func didSelectedDepartureCity(city: Settlement)
    
    
    func didSelectedTransport(atIndex: IndexPath)
    func collectionView(sizeForItemAt indexPath: IndexPath) -> CGSize
}

final class SearchPresenter: NSObject {
    private weak var viewController: SearchViewInputProtocol?
    private let coordinator: SearchCoordinatorProtocol
    
    init(viewController: SearchViewInputProtocol,
         coordinator: SearchCoordinatorProtocol) {
        self.viewController = viewController
        self.coordinator = coordinator
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
}

// MARK: - TransportViewOutputProtocol
extension SearchPresenter: SearchViewOutputProtocol {
    func didSelectedArrivalStation(station: Station) {
        viewController?.setArrivalCityTitle(station.title)
    }
    
    func didSelectedDepartureStation(station: Station) {
        viewController?.setDepartureCityTitle(station.title)
    }
    
    func didSelectedArrivalCity(city: Settlement) {
        viewController?.setArrivalCityTitle(city.title)
    }
    
    func didSelectedDepartureCity(city: Settlement) {
        viewController?.setDepartureCityTitle(city.title)
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
        selectedTransportId = index.row
    }
    
    func didSelectedDate(date: Date) {
        selectedDate = date
    }
    
    func viewDidLoad() {
    }
    
    func didTappedSearch() {
        print(selectedDate,
              selectedTransportId)
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

