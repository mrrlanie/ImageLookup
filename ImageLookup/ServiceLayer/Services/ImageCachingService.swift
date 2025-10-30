//
//  ImageCachingService.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - ImageCachingService

class ImageCachingService {
    
    static let shared = ImageCachingService()
    
    // for on-session cache
    private let memoryCache = NSCache<NSString, UIImage>()
    
    // for between session cache
    
    func cachedImage(for key: String) -> UIImage? {
        return memoryCache.object(forKey: key as NSString)
    }
    
    func cacheImage(image: UIImage, key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
    }
    
    func removeObjectFor(key: String) {
        memoryCache.removeObject(forKey: key as NSString)
    }
    
    func clearCache() {
        memoryCache.removeAllObjects()
    }
}
