//
//  UITextView.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit

extension UITextView {
    
    func addDoneToolbar() {
        let toolBar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: LS("Done"), style: .done, target: self, action: #selector(self.endEditing(_:)))
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        toolBar.snp.makeConstraints { (make) in
            make.height.equalTo(45)
        }
        
        self.inputAccessoryView = toolBar
    }
    
}
