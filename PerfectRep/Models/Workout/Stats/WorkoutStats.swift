//
//  WorkoutStats.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

import CoreLocation

class WorkoutStats {
    
    // GENERAL
    /// related workout reference: DON'T ACCESS, ONLY PASS ON TO THREAD SAFE MANAGERS
    let workout: Workout
    let type: Workout.WorkoutType
        
    
    // DURATION
    let startDate: Date
    let endDate: Date
    let activeDuration: NSMeasurement
 
    
    // ENERGY
    let burnedEnergy: NSMeasurement?
    var timeRelativeBurnedEnergy: RelativeMeasurement? {
        guard let burnedEnergy = burnedEnergy else {
            return nil
        }
        let time = activeDuration.converting(to: UnitDuration.minutes)
        let energy = burnedEnergy.converting(to: UserPreferences.energyMeasurementType.safeValue)
        return RelativeMeasurement(primary: energy, dividing: time)
    }
    
    init(workout: Workout) {
        
        self.workout = workout
        self.type = workout.type
        
        self.startDate = workout.startDate.value
        self.endDate = workout.endDate.value
        self.activeDuration = NSMeasurement(doubleValue: workout.activeDuration.value, unit: UnitDuration.seconds)
        
        self.burnedEnergy = NSMeasurement(doubleValue: workout.burnedEnergy.value ?? 0, unit: UnitEnergy.calories)
        
        
    }
    
    
    

}
