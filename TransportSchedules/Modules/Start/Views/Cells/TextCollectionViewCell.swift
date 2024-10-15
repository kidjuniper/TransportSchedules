//
//  TextTransportCollectionViewCell.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

class TextTransportCollectionViewCell: UICollectionViewCell {
    // MARK: - SubViews
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Properties
    static let cellId = "TextTransportCollectionViewCell"
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

// MARK: - SetUp
private extension TextTransportCollectionViewCell {
    func setUp() {
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(3)
        }
    }
}

// MARK: - TransportCellProtocol
extension TextTransportCollectionViewCell: TransportCellProtocol {
    func configure(withData data: TransportCellData) {
        label.text = data.contentName
        if data.isSelected {
            backgroundColor = .darkGray
        }
        else {
            backgroundColor = .lightGray
        }
    }
}
