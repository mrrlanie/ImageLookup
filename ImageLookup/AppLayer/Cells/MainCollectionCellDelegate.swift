//
//  MainCollectionCellDelegate.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation

// MARK: - MainCollectionCellDelegate

protocol MainCollectionCellDelegate: AnyObject {
    
    func didTapCell(at index: Int)
}
