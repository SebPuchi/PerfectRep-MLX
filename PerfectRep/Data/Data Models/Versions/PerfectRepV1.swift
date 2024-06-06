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
        let startDate = Value.Optional<Date>("startDate")
        let dayIdentifier = Value.Optional<String>("dayIdentifier")
        let burnedEnergy = Value.Optional<Double>("burnedEnergy")
        let healthKitUUID = Value.Optional<UUID>("healthKitID")
        
    }
    
    
    
}
