//
//  MainViewController.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import UIKit
import Foundation

// MARK: - MainViewController

final class MainViewController: UIViewController, MainViewInput {
    
    // MARK: - Public properties
    
    weak var output: MainViewOutput?
    
    // MARK: - Private properties
    
    fileprivate var images: [ImageModel] = []
    
    // MARK: - UI
    
    fileprivate let refreshControl = UIRefreshControl()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(section: MainCollectionViewLayout.createLayout())
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Lookup"
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh),
                                 for: .valueChanged)
        
        registerCells()
        setupUI()
        output?.viewDidLoad()
    }
    
    // MARK: - UI Initialization
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Public functions
    
    func updateImages(images: [ImageModel]) {
        self.images = images
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
    }
    
    func updateCell(at: Int, with image: UIImage?) {
        let cell = collectionView.cellForItem(at: IndexPath(item: at, section: 0)) as? MainCollectionCell
        cell?.configure(with: .init(image: image))
    }
    
    func didTapCell(cell: MainCollectionCell, completion: @escaping (Int) -> Void) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        let index = indexPath.item
        
        guard index >= 0 && index < images.count else {
            completion(index)
            return
        }
        
        animateLeftSwipe(for: cell) { [weak self] in
            guard let self else {
                return
            }
            
            // update in interactor
            completion(index)
            
            images.remove(at: index)
            if images.isEmpty {
                collectionView.reloadData()
            } else {
                collectionView.performBatchUpdates({
                    self.collectionView.deleteItems(at: [indexPath])
                })
            }
        }
    }
    
    // MARK: - Private functions
    
    private func registerCells() {
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.cellIdentifier)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func didPullToRefresh() {
        output?.didPullToRefresh()
        refreshControl.endRefreshing()
    }
}

// MARK: - Animation

extension MainViewController {
    
    func animateLeftSwipe(for cell: UICollectionViewCell, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            guard let self else {
                return
            }
            cell.transform = CGAffineTransform(translationX: view.bounds.width + 100, y: 0)
            cell.alpha = 0
        }, completion: { _ in
            completion()
        })
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard indexPath.item >= 0 && indexPath.item < images.count else {
            return
        }
        output?.willDisplayCell(at: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.cellIdentifier,
                                                            for: indexPath) as? MainCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard !images.isEmpty else {
            return cell
        }
        
        cell.delegate = output
        let image = images[indexPath.item]
        cell.configure(with: .init(image: image.downloadedImage))
        return cell
    }
}
