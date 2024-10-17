//
//  UIButton+SetTitle.swift
//  TransportSchedules
//
//  Created by Nikita Stepanov on 16.10.2024.
//

import Foundation
import UIKit

extension UIButton {
    func setTitle(_ title: String?, for state: UIControl.State) {
        guard let font = K.mainFont else {
            assertionFailure("K.mainFont is not initialized")
            return
        }
        
        let prettyString = NSAttributedString(
            string: title ?? "",
            attributes: [NSAttributedString.Key.font : font]
        )
        
        DispatchQueue.main.async {
            self.setAttributedTitle(prettyString, for: state)
        }
    }
    
    func setBigTitle(_ title: String?, for state: UIControl.State) {
        guard let boldFont = K.mainBoldFont else {
            assertionFailure("K.mainBoldFont is not initialized")
            return
        }
        
        let prettyString = NSAttributedString(
            string: title ?? "",
            attributes: [NSAttributedString.Key.font : boldFont]
        )
        
        DispatchQueue.main.async {
            self.setAttributedTitle(prettyString, for: state)
        }
    }
}
