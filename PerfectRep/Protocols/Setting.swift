//
//  Setting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation
import UIKit


protocol Setting {
    
    var tableViewCell: UITableViewCell { get }
    var section: SettingSection? { get set }
    var usesClosures: Bool { get }
    
    func runSelectAction(controller: SettingsViewController)
    func updateClosures()
    func refresh()
    
}

extension Setting {
    
    func refresh() {
        self.section?.refresh()
    }
    
}
