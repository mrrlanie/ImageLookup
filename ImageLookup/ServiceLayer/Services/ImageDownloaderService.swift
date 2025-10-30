//
//  ImageDownloaderService.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - ImageDownloaderService

class ImageDownloaderService {
    
    // MARK: - Public properties
    
    static let shared = ImageDownloaderService()
    
    // MARK: - Private properties
    
    private let session: URLSession = .init(configuration: .default)
    private let cacheService: ImageCachingService = .shared
    
    // MARK: - Public functions
    
    func downloadImage(from urlString: String,
                       completion: @escaping ((UIImage?, Error?) -> (Void))) {
        // check cache
        if let cachedImage = cacheService.retriveCachedImage(for: urlString) {
            DispatchQueue.main.async {
                completion(cachedImage, nil)
            }
            return
        }
        
        // make url from string
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil, nil)
            }
            return
        }
        
        // simple network
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
                return
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
                return
            }
            
            cacheService.cacheImage(image: image, key: urlString)
            DispatchQueue.main.async {
                completion(image, nil)
            }
        }.resume()
    }
}
