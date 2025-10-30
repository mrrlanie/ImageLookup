//
//  MainInteractorOutput.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

// MARK: - MainInteractorOutput

protocol MainInteractorOutput: AnyObject {
    
    func didChangeData(data: [ImageModel])
}
