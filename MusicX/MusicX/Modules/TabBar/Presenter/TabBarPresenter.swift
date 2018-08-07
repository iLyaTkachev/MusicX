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
    
    private lazy var chartModule: ChartModuleOutput = ChartModule.create() as! ChartModuleOutput
    
    private func insertViewControllers() {
        
        view.viewControllers = [
            chartModule.viewController.wrapToNavigationController()
        ]
    }
}

extension TabBarPresenter : TabBarViewOutput {
    func viewIsReady() {
        view.setupInitialState()
        insertViewControllers()
    }
}

extension TabBarPresenter : TabBarInteractorOutput {
    
}

extension TabBarPresenter : TabBarModuleOutput {
    func present() {
        view.present()
    }
}
