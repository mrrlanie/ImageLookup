//
//  MainCollectionCell.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import UIKit
import Foundation

// MARK: - MainCollectionCell

final class MainCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let cellIdentifier = "ImageLookupCell"
    weak var delegate: MainCollectionCellDelegate?
    fileprivate var cellIndex: Int?
    
    // MARK: - UI
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            // container
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // image
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    // MARK: - Reuse override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Configuration
    
    func configure(with model: MainCollectionCellUIModel) {
        cellIndex = model.cellIndex
        imageView.image = model.image
    }
}
