//
//  LoadingViewController.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit
import Lottie

protocol LoadingViewInputProtocol {
    func stopAnimation()
    func showError()
}

final class LoadingViewController: UIViewController {
    var presenter: LoadingViewOutputProtocol?
    
    // MARK: - Private Properties
    private let loadingAnimationView = LottieAnimationView(name: K.loadingAnimationName)
    private lazy var loadingLabel = makeLabel()
    private lazy var errorLabel = makeLabel()
    private let errorAnimationView = LottieAnimationView(name: K.badConnectionAnimationName)
    private var labelAnimationManager: AnimatedTextViewManagerProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setUp()
    }
}

extension LoadingViewController {
    private func setUp() {
        setUpLayout()
        setUpAnimations()
        setUpBackground()
    }
    
    private func setUpLayout() {
        view.addSubview(loadingAnimationView)
        loadingAnimationView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
            make.center.equalToSuperview()
        }
        
        view.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(loadingAnimationView.snp.bottom)
        }
    }
    
    private func setUpAnimations() {
        loadingAnimationView.loopMode = .loop
        loadingAnimationView.play()
        
        labelAnimationManager = AnimatedTextViewManager(texts: K.loadingTextsTemplate,
                                                      label: loadingLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.labelAnimationManager?.startCycling()
        }
    }
    
    private func setUpBackground() {
        view.backgroundColor = .bgYellow
    }
}

// MARK: - LoadingViewInputProtocol extension
extension LoadingViewController: LoadingViewInputProtocol {
    func showError() {
        loadingAnimationView.removeFromSuperview()
        view.addSubview(errorAnimationView)
        errorAnimationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        errorAnimationView.loopMode = .loop
        errorAnimationView.play()
        
        loadingLabel.removeFromSuperview()
        view.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(errorAnimationView.snp.bottom)
        }
        loadingLabel.text = "Возникла ошибка \nперезапустите приложение"
    }
    
    func stopAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.presenter?.animationDidFinish()
        }
    }
}

// MARK: - UI Factoring
extension LoadingViewController {
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = K.bigFont
        label.textColor = UIColor(named: "accentTextColor")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = K.loadingTextsTemplate.last
        return label
    }
}
