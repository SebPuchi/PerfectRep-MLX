//
//  LabelledDiagramViewDelegate.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit

protocol LabelledDiagramViewDelegate {
    
    func didSelect(sample: TempWorkoutSeriesDataSampleType)
    
}

extension LabelledDiagramViewDelegate {
    
    func didSelect(sample: TempWorkoutSeriesDataSampleType) {}
    
}
