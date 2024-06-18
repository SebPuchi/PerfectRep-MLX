//
//  SettingsModel.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation
import UIKit
import MobileCoreServices


class SettingsModel {
    
    public let title: String
    public let sections: [SettingSection]
    
    public init(title: String = LS("Settings"), sections: [SettingSection]) {
        self.title = title
        self.sections = sections
        sections.forEach { (section) in
            section.model = self
        }
    }
    
    func refresh() {
        sections.forEach { (section) in
            section.settings.forEach { (setting) in
                setting.updateClosures()
            }
        }
    }
    
    /// unsafely returns the `SettingSection` for the given `sectionIndex`
    public subscript(_ sectionIndex: Int) -> SettingSection {
        return self.sections[sectionIndex]
    }
    
    /// unsafely returns a `Setting` for the given `sectionIndex` and `itemIndex`
    public subscript(_ sectionIndex: Int, _ itemIndex: Int) -> Setting {
        return self[IndexPath(row: itemIndex, section: sectionIndex)]
    }
    
    /// unsafely returns a `Setting` for the given `indexPath`
    public subscript(indexPath: IndexPath) -> Setting {
        return self.sections[indexPath.section][indexPath.row]
    }
    
    /// safely returns `SettingSection` for the given `sectionIndex`
    public func safeSection(sectionIndex: Int) -> SettingSection? {
        guard self.sections.indices.contains(sectionIndex) else {
            return nil
        }
        return self[sectionIndex]
    }
    
    /// safely returns a `Setting` for the given `sectionIndex` and `itemIndex`
    public func safeSetting(_ sectionIndex: Int, _ itemIndex: Int) -> Setting? {
        return self.safeSetting(indexPath: IndexPath(item: itemIndex, section: sectionIndex))
    }
    
    /// safely returns a `Setting` for the given `indexPath`
    public func safeSetting(indexPath: IndexPath) -> Setting? {
        return self.safeSection(sectionIndex: indexPath.section)?.safeSetting(itemIndex: indexPath.row)
    }
    
    // MARK: Static
    
    static var custom: SettingsModel {
        return SettingsModel(sections: [
            SettingSection(
                title: LS("Settings.UserSettings"),
                message: LS("Settings.UserSettings.Description"),
                settings: [
                    TextInputSetting(
                        title: LS("Settings.Name"),
                        textFieldText: UserPreferences.name.value,
                        textFieldPlaceholder: LS("Settings.Name"),
                        textFieldValueAction: { (newValue, setting) in
                            UserPreferences.name.value = newValue
                    }
                    ),
                    TextInputSetting(
                        title: { LS("Settings.Weight") },
                        textFieldText: {
                            guard let weight = UserPreferences.weight.value else  {
                                return nil
                            }
                            let value = UserPreferences.weightMeasurementType.convert(fromValue: weight, toPrefered: true)
                            return CustomNumberFormatting.string(from: value, fractionDigits: 2)
                        },
                        textFieldPlaceholder: { LS("Settings.Weight") },
                        keyboardType: .decimalPad,
                        textBehindTextField: UserPreferences.weightMeasurementType.safeValue.symbol,
                        textFieldValueAction: { (newStringValue, setting) in
                            guard let newValue = CustomNumberFormatting.number(from: newStringValue) else {
                                setting.refresh()
                                return
                            }
                            let weightValue = UserPreferences.weightMeasurementType.convert(fromValue: newValue, toPrefered: false)
                            UserPreferences.weight.value = weightValue
                            setting.refresh()
                            
                        }
                    )
            ]),
            SettingSection(
                title: LS("Settings.UnitPreferences"),
                settings: [
                    UserPreferences.energyMeasurementType.setting(forTitle: LS("Settings.EnergyUnit")),
                    UserPreferences.weightMeasurementType.setting(forTitle: LS("Settings.WeightUnit"))
            ]),
            SettingSection(
                title: LS("Settings.RecordingPreferences"),
                message: LS("Settings.RecordingPreferences.Message"),
                settings: [
                    TitleSubTitleSetting(
                        title: { LS("Settings.StandardWorkoutType") },
                        subTitle: { Workout.WorkoutType(rawValue: UserPreferences.standardWorkoutType.value).description },
                        SettingsModel(
                            title: LS("Settings.StandardWorkoutType"),
                            sections: [
                                SettingSection(
                                    title: LS("Workout.Type"),
                                    message: LS("Settings.StandardWorkoutType.Message"),
                                    settings: {
                                        func selectionSetting(withType type: Workout.WorkoutType) -> SelectionSetting {
                                            SelectionSetting(
                                                title: { type.description },
                                                isSelected: { UserPreferences.standardWorkoutType.value == type.rawValue },
                                                selectAction: { (settings, controller, cell) in
                                                    UserPreferences.standardWorkoutType.value = type.rawValue
                                                }
                                            )
                                        }
                                        return [
                                            selectionSetting(withType: .squat),
                                            selectionSetting(withType: .bench),
                                            selectionSetting(withType: .deadlift),
                                            selectionSetting(withType: .rdl)
                                        ]
                                    }()
                                )
                            ]
                        )
                    ),
                    SwitchSetting(
                        title: LS("Settings.MapVisibility"),
                        isSwitchOn: UserPreferences.shouldShowMap.value,
                        switchToggleAction: { (newValue, setting) in
                            UserPreferences.shouldShowMap.value = newValue
                        }
                    ),
                    TitleSubTitleSetting(
                        title: LS("Settings.GPSAccuracy"),
                        subTitle: UserPreferences.gpsAccuracy.value != nil ? (UserPreferences.gpsAccuracy.value == -1 ? LS("Settings.GPSAccuracy.Off") : "\(UserPreferences.gpsAccuracy.value!) m") : LS("Settings.GPSAccuracy.Standard"),
                        {
                            func selectionSetting(withTitle title: String, value: Double?) -> SelectionSetting {
                                let valueString = (value != nil && value ?? -1 > 0) ? "\(value!) m" : ""
                                
                                return SelectionSetting(
                                    title: title,
                                    subTitle: valueString,
                                    isSelected: {
                                        return UserPreferences.gpsAccuracy.value == value
                                    }
                                ) { (setting, controller, cell) in
                                    UserPreferences.gpsAccuracy.value = value
                                }
                            }
                            
                            return SettingsModel(
                                title: LS("Settings.GPSAccuracy"),
                                sections: [
                                    SettingSection(
                                        title: LS("Settings.GPSAccuracy.Title"),
                                        message: LS("Settings.GPSAccuracy.Text"),
                                        settings: [
                                            selectionSetting(withTitle: LS("Settings.GPSAccuracy.Standard"), value: nil),
                                            selectionSetting(withTitle: LS("Settings.GPSAccuracy.High"), value: 20),
                                            selectionSetting(withTitle: LS("Settings.GPSAccuracy.Acceptable"), value: 30),
                                            selectionSetting(withTitle: LS("Settings.GPSAccuracy.LastResort"), value: 50),
                                            selectionSetting(withTitle: LS("Settings.GPSAccuracy.Off"), value: -1)
                                        ]
                                    )
                                ]
                            )
                        }()
                    )
                ]
            ),
            SettingSection(
                title: LS("Settings.DataPreferences"),
                message: LS("Settings.DataPreferences.Message"),
                settings: [
                    TitleSetting(
                        title: LS("Settings.CreateBackup"),
                        doesRedirect: true,
                        selectAction: { (setting, controller, cell) in
                            ShareManager.exportBackupAlertAction(controller: controller)
                        }
                    ),
                    TitleSetting(
                        title: LS("Settings.ImportBackupData"),
                        doesRedirect: true,
                        selectAction: { (setting, controller, cell) in
                            let picker = UIDocumentPickerViewController(documentTypes: ["de.tadris.orbup"], in: .import)
                            picker.modalPresentationStyle = .formSheet
                            picker.delegate = BackupDocumentPickerDelegate.standard
                            BackupDocumentPickerDelegate.standard.currentController = controller
                            controller.present(picker, animated: true)
                        }
                    ),
                    ButtonSetting(
                        title: LS("Settings.DeleteAllData"),
                        selectAction: { (setting, controller, cell) in
                            
                            let alert = UIAlertController(
                                title: LS("Settings.DeleteAll.Confirmation.Title"),
                                message: LS("Settings.DeleteAll.Confirmation.Message"),
                                preferredStyle: .alert,
                                options: [
                                (
                                    title: LS("Delete"),
                                    style: .destructive,
                                    action: { _ in
                                        
                                        func deleteData(completion: (() -> Void)? = nil) {
                                            DispatchQueue.main.async {
                                                _ = controller.startLoading {
                                                    DataManager.deleteAll { (success) in
                                                        if success {
                                                            UserPreferences.reset()
                                                            
                                                            controller.endLoading {
                                                                
                                                                if let completion = completion {
                                                                    completion()
                                                                }
                                                                
                                                                let startController = StartScreenViewController()
                                                                startController.modalTransitionStyle = .crossDissolve
                                                                startController.modalPresentationStyle = .fullScreen
                                                                controller.endLoading {
                                                                    controller.present(startController, animated: true)
                                                                }
                                                            }
                                                            
                                                        } else {
                                                            let errorAlert = UIAlertController(
                                                                title: LS("Settings.DeleteAll.Error.Title"),
                                                                message: LS("Settings.DeleteAll.Error.Message"),
                                                                preferredStyle: .alert,
                                                                options: [
                                                                    (
                                                                        title: LS("Okay"),
                                                                        style: .cancel,
                                                                        action: nil
                                                                    )
                                                                ]
                                                            )
                                                            
                                                            controller.endLoading {
                                                                controller.present(errorAlert, animated: true)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                                                                    
                                }
                                    
                                    )
                                
                            ])
                            
                        }
                
                    )
            ]),
            SettingSection(
                title: LS("Settings.Support"),
                settings: [
                    TitleSetting(
                        title: LS("Settings.TermsOfService"),
                        doesRedirect: true,
                        selectAction: { (setting, controller, cell) in
                            
                            let policyController = PolicyViewController()
                            policyController.type = .termsOfService
                            controller.showDetailViewController(policyController, sender: controller)
                    }
                    ),
                    TitleSetting(
                        title: LS("Settings.PrivacyPolicy"),
                        doesRedirect: true,
                        selectAction: { (setting, controller, cell) in
                            
                            let policyController = PolicyViewController()
                            policyController.type = .privacyPolicy
                            controller.showDetailViewController(policyController, sender: controller)
                    }
                    ),
                    TitleSubTitleSetting(
                        title: LS("Settings.Email"),
                        subTitle: "outrun@tadris.de",
                        doesRedirect: true,
                        selectAction: { (setting, controller, cell) in
                            guard let url = URL(string: "mailto:outrun@tadris.de?subject=OutRun") else {
                                return
                            }
                            UIApplication.shared.open(url) { (success) in
                                if !success {
                                    print("Failed to open Mail")
                                    controller.displayError(withMessage: LS("Settings.Email.Error"))
                                }
                            }
                    }),
                    TitleSubTitleSetting(
                        title: LS("Settings.SourceCode"),
                        subTitle: "github.com",
                        doesRedirect: true,
                        selectAction: { (setting, controller, cell) in
                            guard let url = URL(string: "https://github.com/timfraedrich/OutRun") else {
                                return
                            }
                            UIApplication.shared.open(url) { (success) in
                                if !success {
                                    print("Failed to open link to source code")
                                    controller.displayError(withMessage: LS("Settings.SourceCode.Error"))
                                }
                            }
                    })
            ]),
            SettingSection(
                title: LS("Settings.AppInfo"),
                message: "ⓒ 2020 Tim Fraedrich\n\n",
                settings: [
                    TitleSubTitleSetting(
                        title: LS("Settings.AppVersion"),
                        subTitle: Config.version
                    ),
                    TitleSubTitleSetting(
                        title: LS("Settings.ReleaseStatus"),
                        subTitle: Config.releaseStatus.rawValue
                    )
            ]),
        ])
    }
    
}
