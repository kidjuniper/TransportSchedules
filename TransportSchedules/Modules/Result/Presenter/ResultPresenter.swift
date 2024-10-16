//
//  ResultPresenter.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation
import UIKit

protocol ResultViewOutputProtocol: AnyObject,
                                     UITableViewDataSource,
                                     UITextFieldDelegate {
    func viewDidLoad()
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
}

final class ResultPresenter: NSObject {
    // MARK: - Private Properties
    private var viewController: ResultViewInputProtocol
    private let scheduleManager: ScheduleManagerProtocol
    private lazy var searchData = scheduleManager.requestLastSearchData()
    
    // MARK: - Initializer
    init(scheduleManager: ScheduleManagerProtocol,
         viewController: ResultViewInputProtocol) {
        self.scheduleManager = scheduleManager
        self.viewController = viewController
    }
}

// MARK: - StationsViewOutputProtocol extension
extension ResultPresenter: ResultViewOutputProtocol {
    func viewDidLoad() {
        viewController.reloadSearch()
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        var requiredHeight = K.standartInset * 3
        let labelWidth = UIScreen.main.bounds.width / 4
        let fittingSize = CGSize(width: labelWidth,
                                 height: .greatestFiniteMagnitude)
        
        let mainLabel = UILabel()
        mainLabel.numberOfLines = 0
        mainLabel.text = searchData[indexPath.row].thread.title
        mainLabel.font = K.mainBoldFont
        requiredHeight += mainLabel.sizeThatFits(fittingSize).height
        
        let detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.text = searchData[indexPath.row].thread.carrier?.title ?? ""
        detailLabel.font = K.smallFont
        requiredHeight += detailLabel.sizeThatFits(fittingSize).height
        
        let transportLabel = UILabel()
        transportLabel.numberOfLines = 0
        transportLabel.text = searchData[indexPath.row].thread.vehicle + searchData[indexPath.row].thread.transportSubtype.title + searchData[indexPath.row].thread.number
        transportLabel.font = K.smallFont
        requiredHeight += transportLabel.sizeThatFits(fittingSize).height
        
        return requiredHeight
    }
    
    // TableView dataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.cellId) as! ResultTableViewCell
        cell.configure(with: searchData[indexPath.row])
        return cell
    }
}
