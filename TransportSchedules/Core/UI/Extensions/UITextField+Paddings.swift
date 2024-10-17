//
//  UITextField+Paddings.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 17.10.2024.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: amount,
                                               height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: amount,
                                               height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
