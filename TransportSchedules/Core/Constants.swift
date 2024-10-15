//
//  Constants.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

typealias K = Constants

struct Constants {
    // MARK: - Layout
    static let topSpace = UIScreen.main.bounds.height / UIScreen.main.bounds.width > 2 ? 66.0 : 20.0
    static let datePickerHeight: CGFloat = .init(50.0)
    static let transportCollectionViewHeight: CGFloat = .init(50.0)
    static let imageTransportCollectionViewCellWidth: CGFloat = .init(50.0)
    static func textTransportCollectionViewCellWidth(forNumberOfItems numberOfItems: Int) -> CGFloat {
        .init(UIScreen.main.bounds.width - standartInset * 2 - ((imageTransportCollectionViewCellWidth + 10.0) * CGFloat(numberOfItems - 1)))
    }
    static let standartInset: CGFloat = .init(26.0)
    
    // MARK: - Texts
    static let departureCityPlaceholder = "Москва"
    static let arrivalCityPlaceholder = "Нижний Новгород"
    
    // MARK: - Other Data
    static let defaultTransportCellDataArray: [TransportCellData] = [TransportCellData(type: .text,
                                                                                       isSelected: true,
                                                                                       contentName: "Любой"),
                                                                     TransportCellData(type: .image,
                                                                                       isSelected: false,
                                                                                       contentName: "airplane"),
                                                                     TransportCellData(type: .image,
                                                                                       isSelected: false,
                                                                                       contentName: "train.side.front.car"),
                                                                     TransportCellData(type: .image,
                                                                                       isSelected: false,
                                                                                       contentName: "train.side.rear.car"),
                                                                     TransportCellData(type: .image,
                                                                                       isSelected: false,
                                                                                       contentName: "bus.fill")]
    
    // MARK: - Animations Names
    static let searchScreenAnimationName = "searchScreenAnimation"
}
