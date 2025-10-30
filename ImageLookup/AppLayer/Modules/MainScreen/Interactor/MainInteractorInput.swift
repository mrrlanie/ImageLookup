//
//  MainInteractorInput.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

protocol MainInteractorInput: AnyObject {
    
    func createDummies()
    func loadImage(at index: Int)
    func deleteImage(at index: Int)
    func refreshImages()
}
