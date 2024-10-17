//
//  ResultViewController.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation
import UIKit

protocol ResultViewInputProtocol {
    func reloadSearch()
}

class ResultViewController: UIViewController {
    var presenter: ResultViewOutputProtocol? {
        didSet {
            resultTableView.dataSource = presenter
            resultTableView.delegate = self
        }
    }
    
    // MARK: - Private Properties
    private lazy var swipableIndicator = makeSwipableIndicator()
    private lazy var resultTableView = makeResultTableView()
    private lazy var mainLabel = makeMainLabel()
    
    // MARK: - Lyfe Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

// MARK: - ResultViewInputProtocol extension
extension ResultViewController: ResultViewInputProtocol {
    func reloadSearch() {
        resultTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate extension
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.heightForRowAt(indexPath: indexPath) ?? 0
    }
}

extension ResultViewController {
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
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(swipableIndicator.snp.bottom).offset(K.standartInset)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(K.standartInset)
            make.bottom.equalToSuperview().inset(K.standartInset)
            make.horizontalEdges.equalToSuperview().inset(K.standartInset)
        }
    }
    
    private func setUpBackground() {
        view.backgroundColor = .bgYellow
    }
}

// MARK: - UI Factoring
extension ResultViewController {
    private func makeMainLabel() -> UILabel {
        let label = UILabel()
        label.font = K.bigFont
        label.text = "Результаты поиска:"
        return label
    }
    
    private func makeSwipableIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = .accentText
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }
    
    private func makeResultTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = K.defaultCornerRadius
        tableView.allowsSelection = false
        tableView.clipsToBounds = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ResultTableViewCell.self,
                           forCellReuseIdentifier: ResultTableViewCell.cellId)
        return tableView
    }
}
