//
//  MainFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class MainFactory: MainFactoryProtocol {
    func makeMainViewController() -> MainViewController {
        return MainViewController()
    }
}
