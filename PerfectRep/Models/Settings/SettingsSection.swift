//
//  SettingsSection.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

class SettingSection {
    
    var model: SettingsModel?
    
    public let title: String
    public let message: String?
    public let settings: [Setting]
    
    public init(title: String, message: String? = nil, settings: [Setting]) {
        self.title = title
        self.message = message
        self.settings = settings
        settings.forEach { (setting) in
            var set = setting
            set.section = self
        }
    }
    
    public var count: Int {
        get {
            return self.settings.count
        }
    }
    
    func refresh() {
        model?.refresh()
    }
    
    /// unsafely returns a `Setting` for the given `itemIndex`
    public subscript(_ itemIndex: Int) -> Setting {
        return self.settings[itemIndex]
    }
    
    /// safely returns a `Setting` for the given `itemIndex`
    public func safeSetting(itemIndex: Int) -> Setting? {
        guard self.settings.indices.contains(itemIndex) else {
            return nil
        }
        return self[itemIndex]
    }
    
}
