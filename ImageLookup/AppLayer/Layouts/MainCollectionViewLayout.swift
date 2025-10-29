//
//  MainCollectionViewLayout.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

class MainCollectionViewLayout {
    
    static func createLayout() -> NSCollectionLayoutSection {
        let screenWidth = UIScreen.main.bounds.width
        
        // 390 - 20 / 390 = 0.95
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.95),
                                                            heightDimension: .fractionalWidth(0.95)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.95),
                                                                           heightDimension: .fractionalWidth(0.95)),
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 0
        
        return section
    }
}
