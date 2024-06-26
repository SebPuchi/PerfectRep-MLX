//
//  SelectionSetting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/18/24.
//

import Foundation
import UIKit

class SelectionSetting: TitleSubTitleSetting {
    
    var isSelected: Bool {
        return isSelectedClosure()
    }
    private let isSelectedClosure: () -> Bool
    
    init(title: @escaping () -> String, subTitle: @escaping () -> String = { return "" }, isSelected: @escaping () -> Bool, selectAction: ((Setting, SettingsViewController, UITableViewCell) -> Void)? = nil) {
        self.isSelectedClosure = isSelected
        let action: ((Setting, SettingsViewController, UITableViewCell) -> Void)? = { (setting, controller, cell) in
            selectAction?(setting, controller, cell)
            setting.refresh()
        }
        super.init(title: title, subTitle: subTitle, selectAction: action)
        self.tableViewCell.accessoryType = self.isSelected ? .checkmark : .none
    }
    
    convenience init(title: String, subTitle: String = "", isSelected: @escaping () -> Bool, selectAction: ((Setting, SettingsViewController, UITableViewCell) -> Void)? = nil) {
        self.init(title: { return title }, subTitle: { return subTitle }, isSelected: isSelected, selectAction: selectAction)
        self.usesClosures = false
    }
    
    override var tableViewCell: UITableViewCell {
        get {
            return super.tableViewCell
        }
    }
    
    override func updateClosures() {
        DispatchQueue.main.async {
            self.tableViewCell.accessoryType = self.isSelected ? .checkmark : .none
            if self.usesClosures {
                self.tableViewCell.detailTextLabel?.text = self.subTitle
                self.tableViewCell.textLabel?.text = self.title
            }
        }
    }
    
}
