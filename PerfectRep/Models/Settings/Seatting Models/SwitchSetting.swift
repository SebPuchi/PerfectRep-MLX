//
//  SwitchSetting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/18/24.
//

import UIKit

class SwitchSetting: Setting {
    
    var section: SettingSection?
    var usesClosures: Bool
    
    var title: String {
        return titleClosure()
    }
    
    private let switchToggleAction: ((Bool, Setting) -> Void)?
    private let isOnClosure: () -> Bool
    private let isEnabledClosure: () -> Bool
    private let titleClosure: () -> String
    
    fileprivate lazy var `switch`: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = .accentColor
        switchView.addTarget(self, action: #selector(switchToggled(sender:)), for: .valueChanged)
        
        switchView.isOn = isOnClosure()
        switchView.isEnabled = isEnabledClosure()
        
        return switchView
    }()
    
    fileprivate lazy var titleLabel = UILabel(text: title, font: .preferredFont(forTextStyle: .body))
    
    fileprivate lazy var internalTableViewCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .backgroundColor
        cell.accessoryType = .none
        cell.selectionStyle = .none
        
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.alpha = self.isEnabledClosure() ? 1 : 0.5
        
        cell.contentView.addSubview(self.titleLabel)
        cell.contentView.addSubview(self.switch)
        
        let safeArea = cell.contentView.layoutMarginsGuide
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(safeArea)
            make.left.equalTo(safeArea)
            make.right.equalTo(self.switch.snp.left).offset(-10)
        }
        self.switch.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(safeArea)
        }
        
        cell.isUserInteractionEnabled = isEnabledClosure()
        cell.contentView.alpha = isEnabledClosure() ? 1 : 0.5
        return cell
    }()
    
    init(title: @escaping () -> String, isSwitchOn: @escaping () -> Bool, isEnabled: @escaping () -> Bool = { return true }, switchToggleAction: ((Bool, Setting) -> Void)? = nil) {
        self.switchToggleAction = switchToggleAction
        self.isOnClosure = isSwitchOn
        self.titleClosure = title
        self.isEnabledClosure = isEnabled
        self.usesClosures = true
    }
    
    convenience init(title: String, isSwitchOn: Bool, isEnabled: Bool = true, switchToggleAction: ((Bool, Setting) -> Void)? = nil) {
        self.init(title: { return title }, isSwitchOn: { return isSwitchOn }, isEnabled: { return isEnabled }, switchToggleAction: switchToggleAction)
        self.usesClosures = false
    }
    
    var tableViewCell: UITableViewCell {
        get {
            return internalTableViewCell
        }
    }
    
    @objc func switchToggled(sender: UISwitch) {
        guard let switchToggleAction = switchToggleAction else {
            return
        }
        switchToggleAction(sender.isOn, self)
    }
    
    func runSelectAction(controller: SettingsViewController) {
        return
    }
    
    func updateClosures() {
        if self.usesClosures {
            DispatchQueue.main.async {
                self.switch.setOn(self.isOnClosure(), animated: true)
                self.titleLabel.text = self.title
                self.switch.isEnabled = self.isEnabledClosure()
                self.titleLabel.alpha = self.isEnabledClosure() ? 1 : 0.5
            }
        }
    }
    
}
