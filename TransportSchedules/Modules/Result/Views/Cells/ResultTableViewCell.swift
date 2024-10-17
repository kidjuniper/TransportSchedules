//
//  ResultTableViewCell.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import UIKit
import SnapKit

class ResultTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let cellId = "ResultTableViewCell"
    
    // MARK: - SubViews
    private lazy var mainStack: UIStackView = makeMainStack()
    private lazy var iconStack = makeIconStack()
    private lazy var departureStack: UIStackView = makeDepartureStack()
    private lazy var arrivalStack: UIStackView = makeArrivingStack()
    private lazy var threadStack: UIStackView = makeThreadStack()
    private lazy var threadLabel = makeThreadLabel()
    private lazy var carrierLabel = makeDetailLabel()
    private lazy var transportLabel = makeSmallDetailLabel()
    private lazy var iconImageView = makeTransportIcon()
    private lazy var departureTimeLabel = makeTimeLabel()
    private lazy var departureDetailLabel = makeDetailLabel()
    private lazy var arrivalTimeLabel = makeTimeLabel()
    private lazy var arrivalDetailLabel = makeDetailLabel()

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
    func configure(with data: Segment) {
        threadLabel.text = data.thread.title
        carrierLabel.text = data.thread.carrier?.title ?? ""
        let vihicle = data.thread.number + data.thread.vehicle == "" ? data.thread.transportSubtype.title : data.thread.vehicle
        transportLabel.text = vihicle
        switch data.thread.transportType {
        case .plane:
            iconImageView.image = UIImage(systemName: "airplane")
        case .train:
            iconImageView.image = UIImage(systemName: "train.side.front.car")
        case .suburban:
            iconImageView.image = UIImage(systemName: "train.side.rear.car")
        case .bus:
            iconImageView.image = UIImage(systemName: "bus.fill")
        case .water:
            iconImageView.image = UIImage(systemName: "sailboat")
        case .helicopter:
            iconImageView.image = UIImage(systemName: "")
        }
        
        departureTimeLabel.text = formatTime(from: data.departure)
        arrivalTimeLabel.text = formatTime(from: data.arrival)
        
        departureDetailLabel.text = data.from.title
        arrivalDetailLabel.text = data.to.title
    }
    
    private func formatTime(from isoDateString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        if let date = isoFormatter.date(from: isoDateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return timeFormatter.string(from: date)
        }
        return nil
    }
    
    // MARK: - Private Methods
    private func setupViews() {        
        contentView.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(K.standartInset / 2)
            make.verticalEdges.equalToSuperview().inset(K.standartInset)
        }
        
        threadStack.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        arrivalTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        departureTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        departureStack.snp.makeConstraints { make in
            make.width.equalTo(arrivalStack.snp.width)
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
extension ResultTableViewCell {
    private func makeMainStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [iconStack,
                                                   threadStack,
                                                   departureStack,
                                                   arrivalStack])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = K.standartInset / 2
        return stack
    }
    
    private func makeIconStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [iconImageView,
                                                   UIView()])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = K.standartInset / 2
        return stack
    }
    
    private func makeTransportIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.tintColor = .accentText
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeDetailLabel() -> UILabel {
        let label = UILabel()
        label.font = K.smallFont
        label.textColor = .accentText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeSmallDetailLabel() -> UILabel {
        let label = UILabel()
        label.font = K.smallFont
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeThreadLabel() -> UILabel {
        let label = UILabel()
        label.font = K.mainBoldFont
        label.textColor = .accentText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeThreadStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [threadLabel,
                                                   carrierLabel,
                                                   transportLabel])
        stack.axis = .vertical
        stack.spacing = K.standartInset / 2
        stack.distribution = .fillProportionally
        return stack
    }
    
    private func makeTimeLabel() -> UILabel {
        let label = UILabel()
        label.font = K.mainBoldFont
        label.textColor = .customYellow
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeDepartureStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [departureTimeLabel,
                                                   departureDetailLabel])
        stack.axis = .vertical
        stack.spacing = K.standartInset / 2
        stack.distribution = .fillProportionally
        return stack
    }
    
    private func makeArrivingStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [arrivalTimeLabel,
                                                   arrivalDetailLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = K.standartInset / 2
        return stack
    }
}
