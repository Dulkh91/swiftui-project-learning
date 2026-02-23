//
//  PhotoModelCacheManager.swift
//  SaveImage-fileManager
//
//  Created by Ros Dul on 22/2/26.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager{
    static let instance = PhotoModelCacheManager()
    private init(){}
    
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mg
        return cache
    }()
    
    func add(key: String, value: UIImage){
        return photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String)-> UIImage?{
        return photoCache.object(forKey: key as NSString)
    }
    
    
}
