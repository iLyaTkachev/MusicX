//
//  PlayerAssembly.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class PlayerAssembly {
    
    static func create() -> PlayerViewInput {
        let router = PlayerRouter()
        let interactor = PlayerInteractor()
        let presenter = PlayerPresenter()
        let view = Utils.getViewController(storyboardName: PlayerViewController.storyboardName, vcId: PlayerViewController.vcId) as! PlayerViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
