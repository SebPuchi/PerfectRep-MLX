//
//  UILabel.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/12/24.
//

import Foundation


import UIKit

extension UILabel {
    
    /// Initializes an UILabel without any frame or constraints and the given properties. The standard textColor is .primaryColor
    convenience init(text: String? = nil, textColor: UIColor = .primaryColor, font: UIFont? = nil, numberOfLines: Int? = nil, textAlignment: NSTextAlignment? = nil) {
        
        self.init()
        
        self.text = text
        self.textColor = textColor
        
        if let lFont = font {
            self.font = lFont
        }
        
        if let lNumber = numberOfLines {
            self.numberOfLines = lNumber
        }
        
        if let lAlignment = textAlignment {
            self.textAlignment = lAlignment
        }
        
    }
    
}
