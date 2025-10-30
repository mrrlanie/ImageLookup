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
    
    // MARK: - Public Properties
    
    weak var output: MainInteractorOutput?
    
    // MARK: -  Private Properties
    
    private var data: [ImageModel] = []
    private let cachingService: ImageCachingService = .shared
    private let downloadingService: ImageDownloaderService = .shared
    private var latestDummyCount = 0
    
    // MARK: - Public functions
    
    func createDummies(dummyCount: Int) {
        var models: [ImageModel] = []
        latestDummyCount = dummyCount
        for index in 0...latestDummyCount - 1 {
            models.append(.init(imageUrl: "https://placehold.co/800x6\(index)0.png",
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
                                         completion: { [weak self] image, error in
            guard let self else {
                return
            }
            
            let imageToShow: UIImage? = error == nil ? image : .error
            
            data.insert(.init(imageUrl: modelToLoad.imageUrl,
                              downloadedImage: imageToShow),
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
        createDummies(dummyCount: latestDummyCount)
    }
}
