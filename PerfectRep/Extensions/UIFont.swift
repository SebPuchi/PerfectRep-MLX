//
//  UIFont.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit

extension UIFont {
    
    private func addingAttributes(_ attributes: [UIFontDescriptor.AttributeName:Any] = [:]) -> UIFont {
        return UIFont(descriptor: fontDescriptor.addingAttributes(attributes), size: pointSize)
    }
    
    var withUpperCaseSmallCaps: UIFont {
        return addingAttributes([
            UIFontDescriptor.AttributeName.featureSettings: [
                [
                    UIFontDescriptor.FeatureKey.type: kUpperCaseType,
                    UIFontDescriptor.FeatureKey.type: kUpperCaseSmallCapsSelector
                ]
            ]
        ])
    }
    
    var withLowerCaseSmallCaps: UIFont {
        return addingAttributes([
            UIFontDescriptor.AttributeName.featureSettings: [
                [
                    UIFontDescriptor.FeatureKey.type: kLowerCaseType,
                    UIFontDescriptor.FeatureKey.type: kLowerCaseSmallCapsSelector
                ]
            ]
        ])
    }
    
}
