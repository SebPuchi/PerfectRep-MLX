//
//  UIColor.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/18/24.
//

import Foundation
import UIKit

extension UIColor {
    
    static let accentColor = UIColor(named: "accentColor") ?? .red
    static let accentColorSwapped = UIColor(named: "accentColorSwapped") ?? UIColor.orange.withAlphaComponent(0.9)
    static let primaryColor = UIColor(named: "primaryColor") ?? .black
    static let secondaryColor = UIColor(named: "secondaryColor") ?? UIColor(white: 118/255, alpha: 1)
    static let backgroundColor = UIColor(named: "backgroundColor") ??  UIColor.white
    static let foregroundColor = UIColor(named: "foregroundColor") ?? UIColor(white: 248/255, alpha: 1)
    static let tableViewSeparator = UIColor(white: 0.5, alpha: 0.25)
    
}
