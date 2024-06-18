//
//  KeyboardAvoidanceSetting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/12/24.
//

import Foundation
import UIKit
protocol KeyboardAvoidanceSetting: Setting {
    
    var registerForKeyboardAvoidanceClosure: ((UITableViewCell) -> Void)? { get set }
    
}
