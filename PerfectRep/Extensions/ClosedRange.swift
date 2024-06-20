//
//  ClosedRange.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation

extension ClosedRange where Bound == Double {
    
    var length: Double {
        return self.upperBound - self.lowerBound
    }
    
}
