//
//  DownloadsAssembly.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class DownloadsAssembly {
    
    static func create() -> DownloadsViewInput {
        let router = DownloadsRouter()
        let interactor = DownloadsInteractor()
        let presenter = DownloadsPresenter()
        let view = Utils.getViewController(storyboardName: DownloadsViewController.storyboardName, vcId: DownloadsViewController.vcId) as! DownloadsViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
