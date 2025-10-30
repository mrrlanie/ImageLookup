//
//  ImageDownloaderService.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

class ImageDownloaderService {
    
    static let shared = ImageDownloaderService()
    
    private let session: URLSession
    private let cacheService: ImageCachingService
    
    init() {
        self.session = URLSession(configuration: .default)
        self.cacheService = .shared
    }
    
    func downloadImage(from urlString: String,
                       completion: @escaping ((UIImage?) -> (Void))) {
        // check cache
        
        if let cachedImage = cacheService.cachedImage(for: urlString) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        // make url from string
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        // simple network
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            cacheService.cacheImage(image: image, key: urlString)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
