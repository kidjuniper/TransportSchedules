//
//  SceneDelegate.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinatable?
    
    private let stationListManager = StationListManager(yandexAPIManager: YandexAPIManager())

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        coordinator = makeCoordinator(navigationController: navigationController)
        coordinator?.start()
    }
    
    private func makeCoordinator(navigationController: UINavigationController) -> Coordinatable {
        return AppCoordinator(router: Router(navigationController: navigationController),
                              factory: CoordinatorFactory(),
                              stationListManager: stationListManager)
    }
}

