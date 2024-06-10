//
//  ApplicationStateObservation.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

struct ApplicationStateObservation {
    
    weak var observer: ApplicationStateObserver?
   
    // Reference Dictionary 
    static var observations: [ObjectIdentifier:ApplicationStateObservation] = [:]
    
    static func addObserver(_ observer: ApplicationStateObserver) {
        let identifier = ObjectIdentifier(observer)
        ApplicationStateObservation.observations.updateValue(
            ApplicationStateObservation(observer: observer),
            forKey: identifier
        )
    }
    
    static func removeObserver(_ observer: ApplicationStateObserver) {
        let identifier = ObjectIdentifier(observer)
        ApplicationStateObservation.observations.removeValue(forKey: identifier)
    }
    
    static func stateChanged(to state: ApplicationState) {
        for (identifier, observation) in ApplicationStateObservation.observations {
            
            guard let observer = observation.observer else {
                ApplicationStateObservation.observations.removeValue(forKey: identifier)
                continue
            }
            
            observer.didUpdateApplicationState(to: state)
        }
    }
    
}
