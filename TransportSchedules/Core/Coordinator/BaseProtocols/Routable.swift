//
//  Routable.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation

typealias CompletionBlock = () -> Void

protocol Routable: Presentable { // simple version for simple app :)
    func setRootModule(_ module: Presentable?,
                       hideBar: Bool)
    func dismissModule(animated: Bool,
                       completion: CompletionBlock?)
}

