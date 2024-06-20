//
//  Sequence.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation

extension Sequence {
    func groupBy<U : Comparable>(keyFunc: (Iterator.Element) -> U) -> [(U,[Iterator.Element])] {
        var tupArr: [(U,[Iterator.Element])] = []
        for el in self {
            let key = keyFunc(el)
            if tupArr.last?.0 == key {
                tupArr[tupArr.endIndex-1].1.append(el)
            }
            else {
                tupArr.append((key,[el]))
            }
        }
        return tupArr
    }
}
