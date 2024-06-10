//
//  Workout.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

import CoreLocation
import HealthKit

typealias Workout = PerfectRepV1.Workout

extension Workout: CustomStringConvertible {
    
    var type: WorkoutType {
        get {
            return WorkoutType(rawValue: self.workoutType.value)
        }
    }
    
    //  Provides Memory Address of instances of Workouts
    private var tmpAddress: String {
        get {
            return String(format: "%p", unsafeBitCast(self, to: Int.self))
        }
    }
    
    private static var _stats = [String:WorkoutStats]()
    var cachedStats: WorkoutStats? {
        get {
            return Workout._stats[tmpAddress] ?? nil
        } set(newValue) {
            Workout._stats[tmpAddress] = newValue
        }
    }
    
    
    
    var description: String {
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.roundingIncrement = 2
        measurementFormatter.unitOptions = .naturalScale
        

        let duration = CustomMeasurementFormatting.string(forMeasurement: NSMeasurement(doubleValue: self.endDate.value.distance(to: self.startDate.value), unit: UnitDuration.seconds), type: .time, rounding: .twoDigits)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let start = dateFormatter.string(from: startDate.value)
        let end = dateFormatter.string(from: endDate.value)
        
        guard let energyBurned = self.burnedEnergy.value else {
            return "Workout(type: \(type.debugDescription), start: \(start), end: \(end), duration: \(duration))"
        }
        
        let energy = CustomMeasurementFormatting.string(forMeasurement: NSMeasurement(doubleValue: energyBurned, unit: UnitEnergy.calories), type: .energy, rounding: .wholeNumbers)
        
        return "Workout(type: \(type.debugDescription), start: \(start), end: \(end), duration: \(duration), energyBurned: \(energy))"
    }
    
    enum WorkoutType: CustomStringConvertible, CustomDebugStringConvertible {
        case squat, bench, deadlift, rdl, unknown
        
        init(rawValue: Int) {
            switch rawValue {
            case 0:
                self = .squat
            case 1:
                self = .bench
            case 2:
                self = .deadlift
            case 3:
                self = .rdl
            default:
                self = .unknown
            }
        }
        
        
        var rawValue: Int {
            switch self {
            case .squat:
                return 0
            case .bench:
                return 1
            case .deadlift:
                return 2
            case .rdl:
                return 3
            case .unknown:
                return -1
            }
        }
        
        var description: String {
            switch self {
            case .squat:
                return LS("Workout.Type.Squat")
            case .bench:
                return LS("Workout.Type.Bench")
            case .deadlift:
                return LS("Workout.Type.Deadlift")
            case .rdl:
                return LS("Workout.Type.RDL")
            case .unknown:
                return LS("Workout.Type.Unknown")
            }
        }
        
        var debugDescription: String {
            switch self {
            case .squat:
                return "Squat"
            case .bench:
                return "Bench"
            case .deadlift:
                return "Deadlift"
            case .rdl:
                return "RDL"
            case .unknown:
                return "Unknown"
            }
        }
        
        
        //Metabolic Equivalent of Task values TBD SUBJECT TO CHANGE
        var METSpeedMultiplier: Double {
            switch self {
            case .squat:
                return 1.035
            case .bench:
                return 0.655
            case .deadlift:
                return 0.450
            case .rdl:
                return 0.560
            case .unknown:
                return 0
            }
        }
        
        
    }
    
}
