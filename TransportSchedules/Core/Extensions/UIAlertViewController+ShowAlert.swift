//
//  UIAlertViewController+ShowAlert.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 15.10.2024.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlert(title: String,
                          message: String?,
                          inViewController viewController: UIViewController,
                          actionBlock: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default) { _ in
            actionBlock?()
        })
        
        viewController.present(alert, animated: true,
                               completion: nil)
    }
}
