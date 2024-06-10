//
//  MeasurementUserPreference.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

class MeasurementUserPreference<UnitType> where UnitType: Unit {
    
    private let userPreference: UserPreference.Optional<Int>
    let possibleValues: [UnitType]
    let key: String
    let bigUnits: Bool
    
    init(key: String, possibleValues: [UnitType], bigUnits: Bool = true) {
        self.userPreference = UserPreference.Optional<Int>(key: key)
        self.possibleValues = possibleValues
        self.key = key
        self.bigUnits = bigUnits
    }
    
    var value: UnitType? {
        get {
            let rawValue = userPreference.value ?? -1
            guard self.possibleValues.indices.contains(rawValue) else {
                return nil
            }
            return self.possibleValues[rawValue]
        } set {
            guard let newValue = newValue else {
                userPreference.value = userPreference.defaultValue
                return
            }
            let rawValue = self.possibleValues.firstIndex(of: newValue) ?? self.userPreference.defaultValue
            userPreference.value = rawValue
        }
    }
    
    var safeValue: UnitType {
        get {
            guard let value = self.value else {
                guard let standardUnit = self.standardLocalValue else {
                    return self.possibleValues[0]
                }
                return standardUnit
            }
            return value
        }
    }
    
    var standardValue: UnitType? {
        get {
            guard UnitType.self is StandardizedUnit.Type else {
                return nil
            }
            let standardizedUnit = UnitType.self as! StandardizedUnit.Type
            return (self.bigUnits ? standardizedUnit.standardBigUnit : standardizedUnit.standardUnit) as? UnitType
        }
    }
    
    var standardLocalValue: UnitType? {
        get {
            guard UnitType.self is StandardizedUnit.Type else {
                return nil
            }
            let standardizedUnit = UnitType.self as! StandardizedUnit.Type
            return (self.bigUnits ? standardizedUnit.standardBigLocalUnit : standardizedUnit.standardSmallLocalUnit) as? UnitType
        }
    }
    
    func convert(fromValue value: Double, toPrefered: Bool, rounded: Bool = true) -> Double {
        guard let standardUnit = self.standardValue else {
            return -1
        }
        let preferedUnit = self.safeValue
        let sourceUnit = toPrefered ? standardUnit : preferedUnit
        let targetUnit = toPrefered ? preferedUnit : standardUnit
        let value = UnitConversion.conversion(of: value, from: sourceUnit, to: targetUnit)
        return rounded ? ((value * 100).rounded() / 100) : value
    }
    
    func setting(forTitle title: String) -> Setting {
        
        let settingsModel = SettingsModel(title: title, sections: [
            SettingSection(
                title: LS("Settings.UnitPick.Headline"),
                message: LS("Settings.UnitPick.Message"),
                settings: {
                    var settings = [SelectionSetting]()
                    
                    if let standardUnit = self.standardLocalValue {
                        let selectSetting = SelectionSetting(
                            title: LS("Standard") + " (\(MeasurementFormatter().string(from: standardUnit)))",
                            subTitle: "",
                            isSelected: { () -> Bool in
                                return self.value == nil
                            }
                        ) { (setting, controller, cell) in
                            self.value = nil
                        }
                        settings.append(selectSetting)
                    }
                    
                    for unit in self.possibleValues {
                        let selectSetting = SelectionSetting(
                            title: MeasurementFormatter().string(from: unit),
                            subTitle: "",
                            isSelected: { () -> Bool in
                                return self.value == unit
                            }
                        ) { (setting, controller, cell) in
                            self.value = unit
                        }
                        settings.append(selectSetting)
                    }
                    return settings
                }()
            )
        ])
        
        return TitleSubTitleSetting(
            title: title,
            subTitle: MeasurementFormatter().string(from: self.safeValue),
            settingsModel
        )
        
    }
    
    func delete() {
        self.userPreference.delete()
    }
    
}
