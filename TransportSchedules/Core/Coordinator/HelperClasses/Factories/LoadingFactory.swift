//
//  LoadingFactory.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

final class LoadingFactory: LoadingFactoryProtocol {
    func makeLoadingViewController() -> LoadingViewController {
        return LoadingViewController()
    }
}
