//
//  CodableBundleExtension.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // 1. Locate the JSON file
        
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // 2. Create a property for the data
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create property for the coder
        guard let decodeData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failure to load \(file) from bundle.")
        }
        
        // 5. Decode and return the ready-to-use data
        return decodeData
        
    }
    
}
