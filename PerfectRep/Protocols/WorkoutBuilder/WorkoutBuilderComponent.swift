//
//  WorkoutBuilderComponent.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation

protocol WorkoutBuilderComponent: AnyObject {
    
    /// the `WorkoutBuilder` currently holding this instance of `WorkoutBuilderComponent`
    var builder: WorkoutBuilder? { get set }
    
    /// a boolean indicating if the component is ready for a recording to be started
    var isReady: Bool { get set }
    
    /**
     Notifies the `WorkoutBuilderComponent` when the `WorkoutBuilder`s status changed
     - parameter oldStatus: the old status of the `WorkoutBuilder`
     - parameter newStatus: the new status of the `WorkoutBuilder`
     */
    func statusChanged(from oldStatus: WorkoutBuilder.Status, to newStatus: WorkoutBuilder.Status, timestamp: Date)
    
    /**
     Continues the recording process of a workout setting up the component like it was before finishing to record said workout
     */
    func continueWorkout(from snapshot: TempWorkout, timestamp: Date)
    
    /**
     Resets the `WorkoutBuilderComponent` making it ready for a new recording
     */
    func reset()
    
}

extension WorkoutBuilderComponent {
    
    func statusChanged(from oldStatus: WorkoutBuilder.Status, to newStatus: WorkoutBuilder.Status, timestamp: Date) {}
    
}
