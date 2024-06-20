//
//  BackupDocumentPickerDelegate.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import UIKit
import MobileCoreServices

class BackupDocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    
    static var standard = BackupDocumentPickerDelegate()
    
    var currentController: UIViewController?
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let url = urls.first else {
            return
        }
        
        let closure = self.currentController?.startLoading(asProgress: true, title: LS("Loading"), message: LS("Settings.ImportBackupData.Message"))
        
        BackupManager.insertBackup(url: url, completion: { (success, workouts, events) in
            print("was able to read and load backup:", success)
            
            guard let controller = self.currentController else {
                return
            }
            
            controller.endLoading {
                if success {
                    controller.displayInfoAlert(withMessage: LS("Settings.ImportBackupData.Success"))
                } else {
                    controller.displayError(withMessage: LS("Settings.ImportBackupData.Error"))
                }
            }
        }, progressClosure: { newProgress in
            if let closure = closure {
                closure(newProgress, nil)
            }
        })
        
    }
    
}
