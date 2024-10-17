//
//  CitiesViewController.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

protocol StationsViewInputProtocol {
    func reloadSearch()
    func hideKeyboard()
}

class StationsViewController: UIViewController {
    var presenter: StationsViewOutputProtocol? {
        didSet {
            citiesTableView.dataSource = presenter
            citiesTableView.delegate = self
            selectedCityTextField.delegate = presenter
        }
    }
    
    // MARK: - Private Properties
    private lazy var swipableIndicator = makeSwipableIndicator()
    private lazy var selectedCityTextField = makeTextField()
    private lazy var citiesTableView = makeCitiesTableView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter?.viewDidLoad()
    }
}

extension StationsViewController {
    private func setUp() {
        setUpLayout()
        setUpBackground()
        setUpTargets()
    }
    
    private func setUpLayout() {
        view.addSubview(swipableIndicator)
        swipableIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(10)
            make.width.equalTo(100)
        }
        
        view.addSubview(selectedCityTextField)
        selectedCityTextField.snp.makeConstraints { make in
            make.top.equalTo(swipableIndicator.snp.bottom).offset(K.standartInset)
            make.horizontalEdges.equalToSuperview().inset(K.standartInset)
            make.height.equalTo(60)
        }
        
        view.addSubview(citiesTableView)
        citiesTableView.snp.makeConstraints { make in
            make.top.equalTo(selectedCityTextField.snp.bottom).offset(K.standartInset)
            make.bottom.equalToSuperview().inset(K.standartInset)
            make.horizontalEdges.equalToSuperview().inset(K.standartInset)
        }
    }
    
    private func setUpBackground() {
        view.backgroundColor = .bgYellow
    }
    
    private func setUpTargets() {
        selectedCityTextField.becomeFirstResponder()
        selectedCityTextField.addTarget(self,
                                        action: #selector(textFieldDidChange),
                                        for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        presenter?.filterData(with: textField.text ?? "")
    }
}

// MARK: - UITableViewDelegate extension
extension StationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedCity(withIndexPath: indexPath)
    }
}

extension StationsViewController: StationsViewInputProtocol {
    func hideKeyboard() {
        selectedCityTextField.resignFirstResponder()
    }
    
    func reloadSearch() {
        citiesTableView.reloadData()
    }
}

// MARK: - UI Factoring
extension StationsViewController {
    private func makeSwipableIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = .accentText
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }
    
    private func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .customYellow
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.accentText.cgColor
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(10)
        textField.clipsToBounds = true
        textField.placeholder = "Начните вводить название..."
        return textField
    }
    
    private func makeCitiesTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = K.defaultCornerRadius
        tableView.clipsToBounds = true
        tableView.register(CitiesTableViewCell.self,
                           forCellReuseIdentifier: CitiesTableViewCell.cellId)
        return tableView
    }
}
