//
//  Router.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

final class Router: Routable {
    var toPresent: UIViewController?

    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setRootModule(_ module: Presentable?,
                       hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        guard let navigationController = navigationController else { return }
        navigationController.setViewControllers([controller],
                                                 animated: false)
        navigationController.isNavigationBarHidden = hideBar
    }
    
    func dismissModule(animated: Bool,
                       completion: CompletionBlock?) {
        navigationController?.dismiss(animated: animated,
                                      completion: completion)
    }
}
