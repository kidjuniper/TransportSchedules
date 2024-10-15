//
//  TransportCellsFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

struct TransportCellData {
    var type: TransportCellType
    var isSelected: Bool
    var contentName: String
}

protocol TransportCellProtocol: UICollectionViewCell {
    func configure(withData: TransportCellData)
}

enum TransportCellsFactory {
    static func makeTransportCell(colletionView: UICollectionView,
                                  indexPath: IndexPath,
                                  cellData: TransportCellData) -> UICollectionViewCell {
        switch cellData.type {
        case .image:
            return makeImageCollectionViewCell(colletionView: colletionView,
                                               indexPath: indexPath,
                                               cellData: cellData)
        case .text:
            return makeTextCollectionViewCell(colletionView: colletionView,
                                              indexPath: indexPath,
                                              cellData: cellData)
        }
    }
    
    private static func makeImageCollectionViewCell(colletionView: UICollectionView,
                                                    indexPath: IndexPath,
                                                    cellData: TransportCellData) -> UICollectionViewCell {
        let reuseId = ImageOfTransportCollectionViewCell.cellId
        guard let cell = colletionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                           for: indexPath) as? ImageOfTransportCollectionViewCell else {
            fatalError("Unable to dequeue ImageOfTransportCollectionViewCell")
        }
        cell.configure(withData: cellData)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    private static func makeTextCollectionViewCell(colletionView: UICollectionView,
                                                   indexPath: IndexPath,
                                                   cellData: TransportCellData) -> UICollectionViewCell {
        let reuseId = TextTransportCollectionViewCell.cellId
        guard let cell = colletionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                           for: indexPath) as? TextTransportCollectionViewCell else {
            fatalError("Unable to dequeue TextTransportCollectionViewCell")
        }
        cell.configure(withData: cellData)
        cell.layer.cornerRadius = 10
        return cell
    }
}

enum TransportCellType {
    case text
    case image
}
