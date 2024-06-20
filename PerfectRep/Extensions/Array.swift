//
//  Array.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation

import Foundation

extension Array {
    
    func safeValue(for index: Int) -> Array.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
    
}
