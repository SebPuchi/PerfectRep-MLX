//
//  UIAlertController.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit

extension UIAlertController {
    
    convenience init(title: String, message: String? = nil, preferredStyle: UIAlertController.Style, options: [(title: String, style: UIAlertAction.Style, action: ((UIAlertAction) -> Void)?)], dismissAction: (() -> Void)? = nil) {
        
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        
        for option in options {
            let actionClosure: (UIAlertAction) -> Void = { action in
                option.action?(action)
                dismissAction?()
            }
            let action = UIAlertAction(title: option.title, style: option.style, handler: actionClosure)
            self.addAction(action)
        }
        
    }
    
}
