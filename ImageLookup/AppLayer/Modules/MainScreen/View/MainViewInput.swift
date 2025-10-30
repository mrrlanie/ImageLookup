//
//  MainViewInput.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - MainViewInput

protocol MainViewInput: AnyObject {
    
    func updateImages(images: [ImageModel])
    func updateCell(at index: Int, with image: UIImage?)
    func didTapCell(cell: MainCollectionCell, completion: @escaping (Int) -> Void)
}
