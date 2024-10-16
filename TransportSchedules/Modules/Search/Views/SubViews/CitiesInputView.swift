//
//  CitiesInputView.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit
import SnapKit

// MARK: - Delegate Protocol
protocol CitiesSelectionDelegate: AnyObject {
    func didSelectCitiesOption(citiesIndexes indexes: [String])
}

class CitiesInputView: UIView {
    weak var delegate: CitiesSelectionDelegate?
    
    // MARK: - Private Properties
    private lazy var departureTextField = makeButton(placeholder: K.departureCityPlaceholder)
    private lazy var arrivalTextField = makeButton(placeholder: K.arrivalCityPlaceholder)
    private lazy var lineView = makeLineView()
    private lazy var arrowButton = makeArrowButton()
    private lazy var stackView = makeStackView()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Funcs
extension CitiesInputView {
    // MARK: - Final SetUp
    private func setUp() {
        setUpLayout()
        setUpAppearance()
    }
    
    private func setUpAppearance() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        backgroundColor = .white
        clipsToBounds = true
    }
    
    private func setUpLayout() {
        addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
            guard let superview = arrowButton.superview else {
                return
            }
            make.width.lessThanOrEqualTo(superview.snp.height)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalTo(arrowButton.snp.leading)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        departureTextField.snp.makeConstraints { make in
            make.width.equalTo(arrivalTextField.snp.width)
        }
    }
}

// MARK: - UI Factoring
extension CitiesInputView {
    private func makeButton(placeholder: String) -> UIButton {
        let button = UIButton()
        button.setTitle(placeholder,
                        for: .normal)
        button.setTitleColor(.accentText,
                             for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }
    
    private func makeLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    
    private func makeArrowButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"),
                        for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .accentText
        return button
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [departureTextField,
                                                       lineView,
                                                       arrivalTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }
}
