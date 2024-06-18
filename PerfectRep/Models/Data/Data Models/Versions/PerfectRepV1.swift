//
//  PerfectRepV1.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/6/24.
//

import Foundation
import CoreStore


enum PerfectRepV1 {
    
    static let identifier = "PerfectRepV1"
    static let schema = CoreStoreSchema(
        modelVersion: PerfectRepV1.identifier,
        entities: [
            Entity<PerfectRepV1.Workout>(PerfectRepV1.Workout.identifier)
        ]
    )
    
    // MARK: Workout CoreStore Obj
    class Workout: CoreStoreObject {
        
        static let identifier = "Workout"
        
        let uuid = Value.Optional<UUID>("id")
        let workoutType = Value.Required<Int>("workoutType", initial: -1)
        let startDate = Value.Required<Date>("startDate", initial: .init(timeIntervalSince1970: 0))
        let endDate = Value.Required<Date>("endDate", initial: .init(timeIntervalSince1970: 0))
//        let dayIdentifier = Value.Required<String>("dayIdentifier", initial: "", isTransient: true, customGetter: DataModelValueGetters.dayIdentifier)
        let burnedEnergy = Value.Optional<Double>("burnedEnergy")
        let healthKitUUID = Value.Optional<UUID>("healthKitID")
       
        
//        let activeDuration = Value.Required<Double>("activeDuration", initial: 0, isTransient: true, customGetter: DataModelValueGetters.activeDuration)
        
    }
    
    
    
}
