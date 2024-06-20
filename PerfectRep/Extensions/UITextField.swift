//
//  UITextField.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit
extension UITextField {
    
    func setPaddingPoints(_ left: CGFloat, _ right: CGFloat) {
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
    
    func addDoneToolbar() {
        let toolBar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: LS("Done"), style: .done, target: self, action: #selector(self.endEditing(_:)))
        toolBar.tintColor = .accentColor
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        toolBar.snp.makeConstraints { (make) in
            make.height.equalTo(45)
        }
        
        self.inputAccessoryView = toolBar
    }
    
}
