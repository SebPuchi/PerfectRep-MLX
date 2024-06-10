//
//  LS.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

/// shortened version to get a localized String
func LS(_ key: String, comment: String = "") -> String {
    
    let localisedString = NSLocalizedString(key, comment: comment)
    return localisedString
}
