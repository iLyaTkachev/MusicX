//
//  TabBarModule.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/2/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class TabBarModule : TabBarModuleInput {
    static func create() -> BaseModuleOutput {
        let router = TabBarRouter()
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        let viewController = Utils.getViewController(storyboardName: TabBarViewController.storyboardId, vcId: TabBarViewController.id) as! TabBarViewController
        
        interactor.output = presenter
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        return presenter
    }
}
