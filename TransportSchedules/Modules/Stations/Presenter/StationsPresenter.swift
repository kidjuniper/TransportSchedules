//
//  StationsPresenter.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation
import UIKit

protocol StationsViewOutputProtocol: AnyObject,
                                     UITableViewDataSource,
                                     UITextFieldDelegate {
    func viewDidLoad()
    func selectedCity(withIndexPath: IndexPath)
    func filterData(with text: String)
}

final class StationsPresenter: NSObject {
    // MARK: - Private Properties
    private var viewController: StationsViewInputProtocol
    private let stationsListManager: StationListManagerProtocol
    private var filteredCities: [Settlement] = []
    private let coordinator: StationsCoordinatorProtocol
    
    // MARK: - Initializer
    init(stationsListManager: StationListManagerProtocol,
         viewController: StationsViewInputProtocol,
         coordinator: StationsCoordinatorProtocol) {
        self.stationsListManager = stationsListManager
        self.viewController = viewController
        self.coordinator = coordinator
        filteredCities = stationsListManager.returnCitiesList()
    }
}

// MARK: - StationsViewOutputProtocol extension
extension StationsPresenter: StationsViewOutputProtocol {
    func selectedCity(withIndexPath: IndexPath) {
        let city = filteredCities[withIndexPath.row]
        coordinator.finishFlow?(city)
    }
    
    func viewDidLoad() {
        viewController.reloadSearch()
    }
    
    func filterData(with text: String) {
        filteredCities = stationsListManager.returnCitiesList().filter { text.isEmpty ? true : $0.title.lowercased().contains(text.lowercased())}
        viewController.reloadSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewController.hideKeyboard()
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        filteredCities.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableViewCell.cellId) as! CitiesTableViewCell
        cell.configure(with: filteredCities[indexPath.row])
        return cell
    }
}
