//
//  MainPresenter.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation

final class MainPresenter: MainViewOutput {
    
    private var view: MainViewInput
    private var interactor: MainInteractorInput
    private var router: MainRouterInput
    
    init(view: MainViewInput,
         interactor: MainInteractorInput,
         router: MainRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() { }
}

extension MainPresenter: MainCollectionCellDelegate {
    
    func didTapCell(at index: Int) { }
}
