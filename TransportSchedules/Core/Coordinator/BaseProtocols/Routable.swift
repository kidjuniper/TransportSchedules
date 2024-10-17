//
//  Routable.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

typealias CompletionBlock = () -> Void

protocol Routable: Presentable {
    var root: UIViewController? { get }
    
    func setRootModule(_ module: Presentable?,
                       hideBar: Bool)
    func dismissModule(animated: Bool,
                       completion: CompletionBlock?)
    func presentModule(_ module: Presentable?,
                       animated: Bool,
                       completion: CompletionBlock?)
}

