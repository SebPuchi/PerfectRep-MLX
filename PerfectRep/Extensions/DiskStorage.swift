//
//  DiskStorage.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
import Cache

extension DiskStorage {
    
    /// the directory url of the cache directory
    var directoryURL: URL? {
        
        return URL(fileURLWithPath: self.path)
        
    }
    
    /// the total size of the cache directory in bytes
    var totalSize: Int? {
        
        if let directory = self.directoryURL, let size = self.fileManager.sizeOfDirectory(at: directory) {
            return size
        }
        
        return nil
        
    }
    
}
