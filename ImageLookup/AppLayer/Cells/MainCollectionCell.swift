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
    
    // MARK: - Public properties
    
    static let cellIdentifier = "ImageLookupCell"
    weak var delegate: MainCollectionCellDelegate?
    
    // MARK: - UI
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activityIndicator.stopAnimating()
    }
    
    // MARK: - UI setup
    
    fileprivate func commonInit() {
        contentView.backgroundColor = .white
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(didTapOnCell)))
        
        contentView.addSubview(containerView)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            // container
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // activityView
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            // image
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with model: MainCollectionCellUIModel) {
        guard let image = model.image else {
            imageView.image = UIImage()
            activityIndicator.startAnimating()
            return
        }
        activityIndicator.stopAnimating()
        imageView.image = image
    }
    
    // MARK: - Actions
    
    @objc private func didTapOnCell() {
        delegate?.didTapCell(cell: self)
    }
}
