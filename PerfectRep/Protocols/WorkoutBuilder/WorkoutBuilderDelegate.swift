//
//  WorkoutBuilderDelegate.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import CoreLocation

protocol WorkoutBuilderDelegate: class {
    
    func didUpdate(distanceMeasurement: NSMeasurement)
    func didUpdate(durationMeasurement: NSMeasurement)
    func didUpdate(speedMeasurement: NSMeasurement, rolling: Bool)
    func didUpdate(energyMeasurement: NSMeasurement)
    func didUpdate(paceMeasurement: RelativeMeasurement, rolling: Bool)
    func didUpdate(status: WorkoutBuilder.Status)
    func didUpdate(routeData: [CLLocation])
    func didUpdate(currentLocation location: CLLocation, force: Bool)
    func didUpdate(uiUpdatesSuspended: Bool)
    func informOfInsufficientLocationPermission()
    
}

extension WorkoutBuilderDelegate {
    
    func didUpdate(distanceMeasurement: NSMeasurement) {}
    func didUpdate(durationMeasurement: NSMeasurement) {}
    func didUpdate(speedMeasurement: NSMeasurement, rolling: Bool) {}
    func didUpdate(energyMeasurement: NSMeasurement) {}
    func didUpdate(paceMeasurement: RelativeMeasurement, rolling: Bool) {}
    func didUpdate(status: WorkoutBuilder.Status) {}
    func didUpdate(routeData: [CLLocation]) {}
    func didUpdate(currentLocation: CLLocation, force: Bool) {}
    func didUpdate(uiUpdatesSuspended: Bool) {}
    func informOfInsufficientLocationPermission() {}
    
    func resetAll() {
        self.didUpdate(durationMeasurement: NSMeasurement(doubleValue: 0, unit: UnitDuration.seconds))
        self.didUpdate(energyMeasurement: NSMeasurement(doubleValue: 0, unit: UnitEnergy.kilocalories))
    }
    
}
