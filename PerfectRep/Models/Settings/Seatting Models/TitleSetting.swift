//
//  TitleSetting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/12/24.
//

import Foundation

import UIKit

class TitleSetting: Setting {
    
    var section: SettingSection?
    var usesClosures: Bool
    
    var title: String {
        return titleClosure()
    }
    var doesRedirect: Bool {
        return doesRedirectClosure()
    }
    
    private let titleClosure: () -> String
    private let doesRedirectClosure: () -> Bool
    private let selectAction: ((Setting, SettingsViewController, UITableViewCell) -> Void)?
    
    fileprivate lazy var internalTableViewCell: UITableViewCell = {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.backgroundColor = .backgroundColor
        cell.textLabel?.textColor = .primaryColor
        cell.textLabel?.text = title
        cell.accessoryType = doesRedirect ? .disclosureIndicator : .none
        
        return cell
    }()
    
    init(title: @escaping () -> String, doesRedirect: @escaping () -> Bool = { return false }, selectAction: ((Setting, SettingsViewController, UITableViewCell) -> Void)? = nil) {
        self.titleClosure = title
        self.doesRedirectClosure = doesRedirect
        self.selectAction = selectAction
        self.usesClosures = true
    }
    
    convenience init(title: String, doesRedirect: Bool = false, selectAction: ((Setting, SettingsViewController, UITableViewCell) -> Void)? = nil) {
        self.init(title: { return title }, doesRedirect: { return doesRedirect }, selectAction: selectAction)
        self.usesClosures = false
    }
    
    convenience init(title: String, _ settingsModel: SettingsModel) {
        self.init(title: title, doesRedirect: true, selectAction: { (setting, controller, cell) in
            
            let newSettingsController = SettingsViewController()
            newSettingsController.settingsModel = settingsModel
            controller.notifyOfPresentation(newSettingsController)
            controller.show(newSettingsController, sender: controller)
            
        })
    }
    
    var tableViewCell: UITableViewCell {
        get {
            return internalTableViewCell
        }
    }
    
    func runSelectAction(controller: SettingsViewController) {
        guard let selectAction = selectAction else {
            return
        }
        selectAction(self, controller, tableViewCell)
    }
    
    func updateClosures() {
        if self.usesClosures {
            DispatchQueue.main.async {
                self.tableViewCell.textLabel?.text = self.title
                self.tableViewCell.accessoryType = self.doesRedirect ? .disclosureIndicator : .none
            }
        }
    }
    
}
