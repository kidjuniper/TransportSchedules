//
//  DateSelectionView.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit
import SnapKit

// MARK: - Delegate Protocol
protocol DateSelectionDelegate: AnyObject {
    func didSelectDateOption(_ option: DateOption)
}

// MARK: - DateSelectionView
class DateSelectionView: UIView {
    weak var delegate: DateSelectionDelegate?
    
    // MARK: - Private Properties
    private lazy var todayButton = makeTodayButton()
    private lazy var tomorrowButton = makeTomorrowButton()
    private lazy var dateButton = makeDateButton()
    private lazy var stackView = makeStack()
    private lazy var datePicker = makeDatePicker()
    
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

// MARK: - Private Funcs
extension DateSelectionView {
    // MARK: - Final SetUp
    private func setUp() {
        setUpLayout()
        setUpStack()
        setUpDatePicker()
    }
    
    // MARK: - Other
    private func setUpLayout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(K.datePickerHeight)
        }
        
        addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setUpStack() {
        stackView.layer.cornerRadius = 8
        stackView.clipsToBounds = true
    }
    
    private func setUpDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.layer.opacity = 0
    }
    
    // MARK: - Actions
    @objc private func todayButtonTapped() {
        delegate?.didSelectDateOption(.today)
        highLightButton(button: todayButton)
        hideDatePicker()
    }
    
    @objc private func tomorrowButtonTapped() {
        delegate?.didSelectDateOption(.tomorrow)
        highLightButton(button: tomorrowButton)
        hideDatePicker()
    }
    
    @objc private func dateButtonTapped() {
        let localDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        delegate?.didSelectDateOption(.customDate(localDate))
        highLightButton(button: dateButton)
        showDatePicker()
    }
    
    @objc private func datePicked() {
        let selectedDate = datePicker.date
        delegate?.didSelectDateOption(.customDate(selectedDate))
    }
    
    private func highLightButton(button highlightedButton: UIButton) {
        [todayButton,
         tomorrowButton,
         dateButton].forEach { button in
            if button != highlightedButton {
                button.backgroundColor = .lightGray
                button.tintColor = .black
                button.setTitleColor(.black,
                                     for: .normal)
            }
            else {
                button.backgroundColor = .darkGray
                button.tintColor = .white
                button.setTitleColor(.white,
                                     for: .normal)
            }
        }
    }
    
    // MARK: - DatePicker Handling
    private func showDatePicker() {
        datePicker.layer.opacity = 0
        UIView.animate(withDuration: 0.5) {
            self.datePicker.layer.opacity = 1
        }
    }
    
    private func hideDatePicker() {
        UIView.animate(withDuration: 0.5) {
            self.datePicker.layer.opacity = 0
        }
    }
}

// MARK: - UI Factoring
extension DateSelectionView {
    private func makeTodayButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Сегодня",
                        for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white,
                             for: .normal)
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(todayButtonTapped),
                         for: .touchUpInside)
        return button
    }
    
    private func makeTomorrowButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Завтра",
                        for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black,
                             for: .normal)
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(tomorrowButtonTapped),
                         for: .touchUpInside)
        return button
    }
    
    private func makeDateButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.imagePadding = 5
        let button = UIButton(configuration: config)
        button.setTitle("Дата",
                        for: .normal)
        button.setImage(UIImage(systemName: "calendar"),
                        for: .normal)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.setTitleColor(.black,
                             for: .normal)
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(dateButtonTapped),
                         for: .touchUpInside)
        return button
    }
    
    private func makeStack() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [todayButton,
                                                       tomorrowButton,
                                                       dateButton])
        stackView.axis = .horizontal
        stackView.backgroundColor = .darkGray
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private func makeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self,
                             action: #selector(datePicked),
                             for: .valueChanged)
        return datePicker
    }
}
