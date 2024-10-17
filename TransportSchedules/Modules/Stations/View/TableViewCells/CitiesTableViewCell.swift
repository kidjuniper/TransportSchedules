//
//  CitiesTableViewCell.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import UIKit
import SnapKit

class CitiesTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let cellId = "CitiesTableViewCell"
    
    // MARK: - SubViews
    private lazy var cityLabel = makeMainLabel()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Configure
    func configure(with city: Settlement) {
        cityLabel.text = city.title
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        contentView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(K.standartInset)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        super.setSelected(selected,
                          animated: animated)
    }
}

// MARK: - UI Factoring
extension CitiesTableViewCell {
    private func makeMainLabel() -> UILabel {
        let label = UILabel()
        label.font = K.mainFont
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
