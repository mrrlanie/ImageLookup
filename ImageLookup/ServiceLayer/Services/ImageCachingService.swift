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
    
    // MARK: - Private properties
    
    static let shared = ImageCachingService()
    
    // for on-session cache
    private let memoryCache = NSCache<NSString, UIImage>()
    
    // for between session cache
    private let fileVault = FileManager.default
    
    // URL on disk to save cache
    private let diskCacheURL: URL
    
    // MARK: - Init
    
    init() {
        let userCacheDirectory = fileVault.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        diskCacheURL = userCacheDirectory.appendingPathComponent("ImageCache")
        
        try? fileVault.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }
    
    // MARK: - Public functions
    
    func retriveCachedImage(for key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        } else if let image = retriveFromDisk(key: key) {
            return image
        } else {
            return nil
        }
    }
    
    func cacheImage(image: UIImage, key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        saveOnDisk(image: image, key: key)
    }
    
    func removeObjectFor(key: String) {
        let fileURL = diskCacheURL.appending(path: key)
        memoryCache.removeObject(forKey: key as NSString)
        try? fileVault.removeItem(at: fileURL)
    }
    
    func clearCache() {
        memoryCache.removeAllObjects()
        try? fileVault.removeItem(at: diskCacheURL)
        try? fileVault.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }
    
    // MARK: - Private functions
    
    private func saveOnDisk(image: UIImage, key: String) {
        let fileURL = diskCacheURL.appending(path: key)
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: fileURL)
        }
    }
    
    private func retriveFromDisk(key: String) -> UIImage? {
        let fileURL = diskCacheURL.appending(path: key)
        
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}
