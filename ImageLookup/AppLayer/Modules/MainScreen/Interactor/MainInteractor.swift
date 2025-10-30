//
//  MainInteractor.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - MainInteractor

final class MainInteractor: MainInteractorInput {
    
    weak var output: MainInteractorOutput?
    
    // MARK: - Properties
    
    private var data: [ImageModel] = []
    private let cachingService: ImageCachingService = .shared
    private let downloadingService: ImageDownloaderService = .shared
    
    func createDummies() {
        var models: [ImageModel] = []
        for _ in 0...5 {
            models.append(.init(imageUrl: "https://placehold.co/800x600.png",
                                downloadedImage: nil))
        }
        data = models
        output?.didChangeData(data: data)
    }
    
    func loadImage(at index: Int) {
        let modelToLoad = data[index]
        guard modelToLoad.downloadedImage == nil else {
            return
        }
        
        downloadingService.downloadImage(from: modelToLoad.imageUrl,
                                         completion: { [weak self] image in
            guard let self else {
                return
            }
            
            data.insert(.init(imageUrl: modelToLoad.imageUrl,
                              downloadedImage: image),
                        at: index)
            data.remove(at: index + 1)
            output?.didChangeData(data: data)
        })
    }
    
    func deleteImage(at index: Int) {
        let modelToDelete = data[index]
        cachingService.removeObjectFor(key: modelToDelete.imageUrl)
        data.remove(at: index)
    }
    
    func refreshImages() {
        cachingService.clearCache()
        createDummies()
    }
}
