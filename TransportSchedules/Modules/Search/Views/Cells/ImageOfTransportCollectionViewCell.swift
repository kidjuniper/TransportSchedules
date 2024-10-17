//
//  ImageOfTransportCollectionViewCell.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

class ImageOfTransportCollectionViewCell: UICollectionViewCell {
    // MARK: - SubViews
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    static let cellId = "ImageCollectionViewCell"
    
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
private extension ImageOfTransportCollectionViewCell {
    func setUp() {
        setUpLayout()
    }
    
    func setUpLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}

// MARK: - TransportCellProtocol
extension ImageOfTransportCollectionViewCell: TransportCellProtocol {
    func configure(withData data: TransportCellData) {
        imageView.image = UIImage(systemName: data.contentName)
        if data.isSelected {
            imageView.tintColor = .black
            backgroundColor = .darkGray
        }
        else {
            imageView.tintColor = .white
            backgroundColor = .lightGray
        }
    }
}
