//
//  UserPreferences.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation
import UIKit


struct UserPreferences {
    
    /// saves if app is set up
    static let isSetUp = UserPreference.Required<Bool>(key: "isSetUp", defaultValue: false)
    
    /// saves the users name
    static let name = UserPreference.Optional<String>(key: "name")
    /// saves the users weight in lbs
    static let weight = UserPreference.Optional<Double>(key: "weight")
    
    //Define standard type as recording workout - will most likely remove this later
    static let standardWorkoutType = UserPreference.Required<Int>(key: "standardWorkoutType", defaultValue: 0)
    
    //Examine depend
    static let shouldShowMap = UserPreference.Required<Bool>(key: "shouldShowMap", defaultValue: true)
    static let gpsAccuracy = UserPreference.Optional<Double>(key: "gpsAccuracy", initialValue: nil)
  

    static let energyMeasurementType = MeasurementUserPreference<UnitEnergy>(key: "energyMeasurementType", possibleValues: [.kilocalories, .kilojoules])
    
    static let weightMeasurementType = MeasurementUserPreference<UnitMass>(key: "weightMeasurementType", possibleValues: [.pounds, .kilograms])
    
    static func reset() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}
