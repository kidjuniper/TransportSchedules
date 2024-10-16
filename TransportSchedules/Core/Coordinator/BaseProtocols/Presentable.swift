//
//  UIViewController+Presentable.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

protocol Presentable {
    var toPresent: UIViewController? { get }
}
 
extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
    
    func showAlert(title: String,
                   message: String? = nil) {
        UIAlertController.showAlert(title: title,
                                    message: message,
                                    inViewController: self,
                                    actionBlock: nil)
    }
}
