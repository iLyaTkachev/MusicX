//
//  TabBarAssembly.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/2/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class TabBarAssembly {
    static func create() -> TabBarViewInput {
        let router = TabBarRouter()
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        let view = Utils.getViewController(storyboardName: TabBarViewController.storyboardId, vcId: TabBarViewController.id) as! TabBarViewController
        
        interactor.output = presenter
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
