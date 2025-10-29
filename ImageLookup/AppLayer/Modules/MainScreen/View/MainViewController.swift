//
//  MainViewController.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import UIKit
import Foundation

final class MainViewController: UIViewController, MainViewInput {
    
    // MARK: - Output
    
    weak var output: MainViewOutput?
    
    // MARK: - Properties
    
    fileprivate var images: [UIImage] = []
    
    // MARK: - UI
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(section: MainCollectionViewLayout.createLayout())
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Lookup"
        registerCells()
        setupUI()
        output?.viewDidLoad()
    }
    
    private func registerCells() {
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.cellIdentifier)
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.cellIdentifier,
                                                            for: indexPath) as? MainCollectionCell else {
            return UICollectionViewCell()
        }
        cell.delegate = output
        let image = images[indexPath.item]
        cell.configure(with: .init(cellIndex: indexPath.item, image: image))
        return cell
    }
}
