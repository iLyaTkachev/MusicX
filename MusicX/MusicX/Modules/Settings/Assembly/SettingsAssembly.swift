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
        let router = ChartRouter()
        let interactor = ChartInteractor()
        let presenter = ChartPresenter()
        let view = Utils.getViewController(storyboardName: ChartViewController.storyboardId, vcId: ChartViewController.id) as! ChartViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        view.cellBuider = ChartCellBuilder()
        view.tableVC = UniversalTableViewController()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.currentMediaType = .track
        presenter.requestedMediaType = .track
        
        return view
    }
}
