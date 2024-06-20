//
//  URL.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation
extension URL {
    
    /// the file size of the file at the given `URL` in bytes
    var fileSize: Int? {
        
        do {
            
            let file = try self.resourceValues(forKeys: [.totalFileAllocatedSizeKey, .fileAllocatedSizeKey])
            return file.totalFileAllocatedSize ?? file.fileAllocatedSize
            
        } catch {
            
            print("Failed to calculate size of file at \(self.absoluteString) because an error occured:", error)
            return nil
            
        }
        
    }
    
}
