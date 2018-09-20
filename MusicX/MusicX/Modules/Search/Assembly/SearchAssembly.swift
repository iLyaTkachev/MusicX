//
//  SearchAssembly.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class SearchAssembly {
    
    static func create() -> SearchViewInput {
        let router = SearchRouter()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let view = Utils.getViewController(storyboardName: SearchViewController.storyboardName, vcId: SearchViewController.vcId) as! SearchViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.currentMediaType = .track
        
        return view
    }
}
