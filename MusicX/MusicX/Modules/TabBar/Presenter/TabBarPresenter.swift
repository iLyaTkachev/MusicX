//
//  TabBarPresenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/7/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class TabBarPresenter {
    weak var view: TabBarViewInput!
    var interactor: TabBarInteractorInput!
    var router: TabBarRouterInput!
    
    private lazy var chartView: ChartViewInput = ChartAssembly.create()
    private lazy var searchView: SearchViewInput = SearchAssembly.create()
    private lazy var playerView: PlayerViewInput = PlayerAssembly.create()
    private lazy var downloadsView: DownloadsViewInput = DownloadsAssembly.create()
    private lazy var settingsView: SettingsViewInput = SettingsAssembly.create()
    
    private func insertViewControllers() {
        
        view.viewControllers = [
            chartView.viewController.wrapToNavigationController(),
            searchView.viewController.wrapToNavigationController(),
            playerView.viewController.wrapToNavigationController(),
            downloadsView.viewController.wrapToNavigationController(),
            settingsView.viewController.wrapToNavigationController()
        ]
    }
}

//Mark: - TabBarViewOutput

extension TabBarPresenter : TabBarViewOutput {
    func viewIsReady() {
        view.setupInitialState()
        insertViewControllers()
    }
}

//Mark: - TabBarInteractorOutput

extension TabBarPresenter : TabBarInteractorOutput {
    
}
