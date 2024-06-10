//
//  ApplicationStateObserver.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

protocol ApplicationStateObserver: AnyObject {
    
    func didUpdateApplicationState(to state: ApplicationState)
    
}

extension ApplicationStateObserver {
    
    func didUpdateApplicationState(to state: ApplicationState) {}
    
    func startObservingApplicationState() {
        ApplicationStateObservation.addObserver(self)
    }
    
    func stopObservingApplicationState() {
        ApplicationStateObservation.removeObserver(self)
    }
    
}

