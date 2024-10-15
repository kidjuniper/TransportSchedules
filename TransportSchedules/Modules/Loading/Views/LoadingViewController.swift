//
//  LoadingViewController.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

protocol LoadingViewInputProtocol {
    func SearchAnimation()
}

final class LoadingViewController: UIViewController {
    var presenter: LoadingViewOutputProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

// MARK: - LoadingViewInputProtocol extension
extension LoadingViewController: LoadingViewInputProtocol {
    func SearchAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presenter?.animationDidFinish()
        }
    }
}
