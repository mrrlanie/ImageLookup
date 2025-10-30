//
//  MainInteractorInput.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - MainInteractorInput

protocol MainInteractorInput: AnyObject {
    
    func createDummies(dummyCount: Int)
    func loadImage(at index: Int)
    func deleteImage(at index: Int)
    func refreshImages()
}
