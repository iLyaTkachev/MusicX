//
//  SettingsAssembly.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/29/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class SettingsAssembly {
    
    static func create() -> SettingsViewInput {
        let router = SettingsRouter()
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter()
        let view = Utils.getViewController(storyboardName: SettingsViewController.storyboardName, vcId: SettingsViewController.vcId) as! SettingsViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter

        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
