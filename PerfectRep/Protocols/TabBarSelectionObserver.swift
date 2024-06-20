//
//  TabBarSelectionObserver.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit

protocol TabBarSelectionObserver: UIViewController {
    
    func willGetSelected()
    func willGetDeselected(newController: UIViewController)
    
}

extension TabBarSelectionObserver {
    
    func willGetSelected() {}
    func willGetDeselected(newController: UIViewController) {}
    
}
