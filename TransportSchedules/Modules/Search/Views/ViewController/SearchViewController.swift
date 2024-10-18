//
//  SearchViewController.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit
import Lottie

protocol SearchViewInputProtocol: AnyObject,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout {
    func updateSelectedTransport()
    func showNothingFoundPopUp()
    func showLoading()
    func stopShowingLoading()
    func setArrivalCityTitle(_ title: String)
    func setDepartureCityTitle(_ title: String)
}

final class SearchViewController: UIViewController {
    var presenter: SearchViewOutputProtocol? {
        didSet {
            transportCollection.delegate = self
            transportCollection.dataSource = presenter
        }
    }
    
    // MARK: - Private Properties
    private lazy var label = makeLabel()
    private lazy var citiesSelectionView = makeCitiesSelectionView()
    private lazy var dateSelectionView = makeDateSelectionView()
    private lazy var transportCollection = makeTransportCollectionView()
    private lazy var searchButton = makeSearchButton()
    private lazy var stackView = makeStackView()
    private lazy var loadingIndicator = makeLodingIndicator()
    private let animationView = LottieAnimationView(name: K.searchScreenAnimationName)
    
    // MARK: - Constraints
    private lazy var dateSelectionViewHeightConstraint = dateSelectionView.heightAnchor.constraint(equalToConstant: 50)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgYellow
        setUp()
    }
}

// MARK: - SearchViewInputProtocol extension
extension SearchViewController: SearchViewInputProtocol {
    func showLoading() {
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
        }
    }
    
    func stopShowingLoading() {
        loadingIndicator.removeFromSuperview()
    }
    
    func showNothingFoundPopUp() {
        let alert = UIAlertController(title: "Прямых рейсов по вашему запросу не найдено",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func setArrivalCityTitle(_ title: String) {
        citiesSelectionView.setArrivalCIty(title)
    }
    
    func setDepartureCityTitle(_ title: String) {
        citiesSelectionView.setDepartureCIty(title)
    }
    
    func updateSelectedTransport() {
        transportCollection.reloadData()
    }
    
    // CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectedTransport(atIndex: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter?.collectionView(sizeForItemAt: indexPath) ?? CGSize.zero
    }
}

// MARK: - DateSelectionDelegate extension
extension SearchViewController: DateSelectionDelegate {
    func didSelectDateOption(_ option: DateOption) {
        switch option {
        case .today,
                .tomorrow:
            makeDateSelectorThin()
        case .customDate:
            makeDateSelectorWide()
        }
        presenter?.didSelectedDate(date: option.localizedDate)
    }
}

// MARK: - StationsSelectionDelegate extension
extension SearchViewController: StationsSelectionDelegate {
    func swap() {
        presenter?.swap()
    }
    
    func didTappedSelectArrivalStation() {
        presenter?.didTappedArrivalStation()
    }
    
    func didTappedSelectDepartureStation() {
        presenter?.didTappedDepartureStation()
    }
}

// MARK: - Private Funcs
extension SearchViewController {
    private func setUp() {
        setUpLayout()
        setUpAnimatedView()
    }
    
    private func setUpLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(K.standartInset)
            make.top.equalToSuperview().inset(K.topSpace)
            make.height.lessThanOrEqualToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalToSuperview()
        }
        
        citiesSelectionView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalToSuperview()
        }
        
        dateSelectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        transportCollection.snp.makeConstraints { make in
            make.height.equalTo(K.transportCollectionViewHeight)
            make.width.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalToSuperview()
        }
        
        dateSelectionViewHeightConstraint.isActive = true
    }
    
    private func setUpAnimatedView() {
        animationView.play()
        animationView.loopMode = .loop
    }
    
    private func makeDateSelectorWide() {
        updateDateSelectorHeight(withConstant: 100)
    }
    
    private func makeDateSelectorThin() {
        updateDateSelectorHeight(withConstant: K.datePickerHeight)
    }
    
    private func updateDateSelectorHeight(withConstant constants: CGFloat) {
        NSLayoutConstraint.deactivate([self.dateSelectionViewHeightConstraint])
        self.dateSelectionViewHeightConstraint.constant = constants
        UIView.animate(withDuration: 0.5) {
            self.dateSelectionViewHeightConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func searchButtonTapped() {
        presenter?.didTappedSearch()
    }
}

// MARK: - UI Factoring
extension SearchViewController {
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = "Расписание пригородного и \nмеждугородного транспорта:"
        label.font = K.mainBoldFont
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .accentText
        return label
    }
    
    private func makeCitiesSelectionView() -> StationsInputView {
        let stationsSelector = StationsInputView()
        stationsSelector.delegate = self
        return stationsSelector
    }
    
    private func makeDateSelectionView() -> DateSelectionView {
        let dateSelector = DateSelectionView()
        dateSelector.delegate = self
        return dateSelector
    }
    
    private func makeTransportCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        let transportCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: flowLayout)
        transportCollectionView.register(TextTransportCollectionViewCell.self,
                                         forCellWithReuseIdentifier: TextTransportCollectionViewCell.cellId)
        transportCollectionView.register(ImageOfTransportCollectionViewCell.self,
                                         forCellWithReuseIdentifier: ImageOfTransportCollectionViewCell.cellId)
        transportCollectionView.backgroundColor = .clear
        return transportCollectionView
    }
    
    private func makeSearchButton() -> UIButton {
        let searchButton = UIButton(type: .system)
        searchButton.setBigTitle("Найти",
                              for: .normal)
        searchButton.setTitleColor(.accentText,
                                   for: .normal)
        searchButton.backgroundColor = .customYellow
        searchButton.layer.cornerRadius = K.defaultCornerRadius
        searchButton.clipsToBounds = true
        searchButton.addTarget(self,
                               action: #selector(searchButtonTapped),
                               for: .touchUpInside)
        return searchButton
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label,
                                                       citiesSelectionView,
                                                       dateSelectionView,
                                                       transportCollection,
                                                       searchButton,
                                                       animationView])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    private func makeLodingIndicator() -> UIActivityIndicatorView {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = .accentText
        loadingIndicator.startAnimating()
        return loadingIndicator
    }
}
