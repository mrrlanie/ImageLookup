//
//  MainScreenConfigurator.swift
//  ImageLookup
//
//  Created by Дарья Пахомова on 29.10.2025.
//

import Foundation
import UIKit

// MARK: - MainScreenConfigurator

class MainScreenConfigurator {
    
    func configure() -> UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        let presenter = MainPresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
