//
//  MainPresenter.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - MainPresenter

final class MainPresenter: MainViewOutput {
    
    // MARK: - Private properties
    
    private var view: MainViewInput
    private var interactor: MainInteractorInput
    private var router: MainRouterInput
    
    fileprivate var isDeletionInProgress = false
    
    // MARK: - Init
    
    init(view: MainViewInput,
         interactor: MainInteractorInput,
         router: MainRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Public functions
    
    func viewDidLoad() {
        interactor.createDummies(dummyCount: 6)
    }
    
    func didPullToRefresh() {
        interactor.refreshImages()
    }
    
    func willDisplayCell(at: Int) {
        interactor.loadImage(at: at)
    }
}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    
    func didChangeData(data: [ImageModel]) {
        view.updateImages(images: data)
    }
}
 
// MARK: - MainCollectionCellDelegate

extension MainPresenter: MainCollectionCellDelegate {
    
    func didTapCell(cell: MainCollectionCell) {
        if isDeletionInProgress {
            return
        } else {
            isDeletionInProgress = true
            view.didTapCell(cell: cell) { [weak self] index in
                guard let self else {
                    return
                }
                
                interactor.deleteImage(at: index)
                isDeletionInProgress = false
            }
        }
    }
}
