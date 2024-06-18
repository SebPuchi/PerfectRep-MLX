//
//  UserPreference.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation


enum UserPreference {

    class Required<Object> {
        
        let key: String
        let defaultValue: Object
        
        init(key: String, defaultValue: Object) {
            self.key = key
            self.defaultValue = defaultValue
        }
        
        var value: Object {
            get {
                let value = UserDefaults.standard.object(forKey: self.key) as? Object
                return value ?? defaultValue
            } set {
                UserDefaults.standard.set(newValue, forKey: self.key)
            }
        }
        
        func delete() {
            UserDefaults.standard.removeObject(forKey: self.key)
        }
        
    }
    
    class Optional<Object> {
        
        let key: String
        let defaultValue: Object?
        
        init(key: String, defaultValue: Object? = nil, initialValue: Object? = nil) {
            self.key = key
            self.defaultValue = defaultValue
            let initialValueKey = key + ".initialValueSet"
            if initialValue != nil && !UserDefaults.standard.bool(forKey: initialValueKey) {
                self.value = initialValue!
                UserDefaults.standard.set(true, forKey: initialValueKey)
            }
        }
        
        var value: Object? {
            get {
                let value = UserDefaults.standard.object(forKey: self.key) as? Object
                return value ?? defaultValue
            } set {
                guard let newValue = newValue else {
                    UserDefaults.standard.removeObject(forKey: self.key)
                    return
                }
                UserDefaults.standard.set(newValue, forKey: self.key)
            }
        }
        
        func delete() {
            UserDefaults.standard.removeObject(forKey: self.key)
        }
        
    }

}
