//
//  CitiesViewController.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

class StationsViewController: UIViewController {
    // MARK: - Private Properties
    private lazy var swipableIndicator = makeSwipableIndicator()
    private lazy var selectedCityTextField = makeTextField()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
       
    }
}

extension StationsViewController {
    private func setUp() {
        setUpLayout()
        setUpBackground()
    }
    
    private func setUpLayout() {
        view.addSubview(swipableIndicator)
        swipableIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(10)
            make.width.equalTo(100)
        }
    }
    
    private func setUpBackground() {
        view.backgroundColor = .bgYellow
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
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        return textField
    }
}
