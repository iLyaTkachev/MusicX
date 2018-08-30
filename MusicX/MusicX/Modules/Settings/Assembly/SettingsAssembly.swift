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
        let view = Utils.getViewController(storyboardName: SettingsViewController.storyboardId, vcId: SettingsViewController.id) as! SettingsViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        //view.cellBuider = ChartCellBuilder()
        //view.tableVC = UniversalTableViewController()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
