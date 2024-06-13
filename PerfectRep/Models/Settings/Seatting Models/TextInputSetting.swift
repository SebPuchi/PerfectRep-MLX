//
//  TextInputSetting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/12/24.
//

import Foundation
import UIKit

class TextInputSetting: NSObject, Setting, KeyboardAvoidanceSetting, UITextFieldDelegate {
    
    var section: SettingSection?
    var usesClosures: Bool
    
    private let titleClosure: () -> String
    private let initialTextFieldText: String?
    private let textFieldTextClosure: (() -> String?)?
    private let textFieldPlaceholderClosure: () -> String?
    private let keyboardType: UIKeyboardType
    private let textBehindTextField: String?
    private let textFieldValueAction: ((String?, Setting) -> Void)?
    
    public var registerForKeyboardAvoidanceClosure: ((UITableViewCell) -> Void)?
    
    fileprivate lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .primaryColor
        textField.placeholder = self.textFieldPlaceholderClosure()
        textField.text = self.initialTextFieldText ?? self.textFieldTextClosure?()
        textField.layer.cornerRadius = 10
        textField.delegate = self
        textField.keyboardType = self.keyboardType
        textField.textAlignment = .right
        textField.clipsToBounds = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        
        textField.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(32)
        }
        
        textField.addDoneToolbar()
        
        return textField
    }()
    
    fileprivate lazy var titleLabel = UILabel(text: self.titleClosure(), font: .preferredFont(forTextStyle: .body))
    
    fileprivate lazy var behindLabel = UILabel(text: self.textBehindTextField, textColor: .secondaryColor, font: .preferredFont(forTextStyle: .body))
    
    fileprivate lazy var internalTableViewCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .backgroundColor
        cell.accessoryType = .none
        cell.selectionStyle = .none
        
        let safeArea = cell.contentView.layoutMarginsGuide
        
        titleLabel.adjustsFontForContentSizeCategory = true
        
        cell.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(safeArea)
            make.left.equalTo(safeArea)
        }
        
        cell.contentView.addSubview(self.textField)
        
        self.textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(safeArea)
            make.left.equalTo(titleLabel.snp.right)
        }
        
        if self.textBehindTextField == nil {
            
            self.textField.snp.makeConstraints { (make) in
                make.right.equalTo(safeArea)
            }
            
        } else {
            
            behindLabel.adjustsFontForContentSizeCategory = true
            
            cell.contentView.addSubview(behindLabel)
            
            behindLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(textField)
                make.right.equalTo(safeArea)
                make.left.equalTo(self.textField.snp.right).offset(10)
            }
            
        }
        
        return cell
    }()
    
    init(title: @escaping () -> String, initialTextFieldText: String? = nil, textFieldText: (() -> String?)? = nil, textFieldPlaceholder: @escaping () -> String? = { return nil }, keyboardType: UIKeyboardType = .default, textBehindTextField: String? = nil, textFieldValueAction: ((String?, Setting) -> Void)? = nil) {
        self.titleClosure = title
        self.initialTextFieldText = initialTextFieldText
        self.textFieldTextClosure = textFieldText
        self.textFieldPlaceholderClosure = textFieldPlaceholder
        self.keyboardType = keyboardType
        self.textBehindTextField = textBehindTextField
        self.textFieldValueAction = textFieldValueAction
        self.usesClosures = true
    }
    
    convenience init(title: String, textFieldText: String? = nil, textFieldPlaceholder: String? = nil, keyboardType: UIKeyboardType = .default, textBehindTextField: String? = nil, textFieldValueAction: ((String?, Setting) -> Void)? = nil) {
        self.init(title: { return title }, initialTextFieldText: textFieldText, textFieldPlaceholder: { return textFieldPlaceholder }, keyboardType: keyboardType, textBehindTextField: textBehindTextField, textFieldValueAction: textFieldValueAction)
        self.usesClosures = false
    }
    
    var tableViewCell: UITableViewCell {
        get {
            return internalTableViewCell
        }
    }
    
    func runSelectAction(controller: SettingsViewController) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        registerForKeyboardAvoidanceClosure?(self.tableViewCell)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let textFieldShouldReturnAction = textFieldValueAction {
            textFieldShouldReturnAction(textField.text, self)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    func updateClosures() {
        if self.usesClosures {
            DispatchQueue.main.async {
                self.titleLabel.text = self.titleClosure()
                self.textField.placeholder = self.textFieldPlaceholderClosure()
                if let textFieldClosure = self.textFieldTextClosure {
                    self.textField.text = textFieldClosure()
                }
            }
        }
    }
    
}
