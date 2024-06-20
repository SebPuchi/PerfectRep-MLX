//
//  TempWorkoutSeriesDataSampleType.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation


protocol TempWorkoutSeriesDataSampleType {
    init?<T: WorkoutSeriesDataSampleType>(sample: T)
}
