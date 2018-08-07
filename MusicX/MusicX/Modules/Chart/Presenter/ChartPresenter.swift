//
//  Presenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartPresenter {
    weak var view: ChartViewInput!
    var interactor: ChartInteractorInput!
    var router: ChartRouterInput!
    
    private var tracks: [Track] = []

}

//Mark: - ChartInteractorOutput

extension ChartPresenter : ChartInteractorOutput {
    func didFetchWithSuccess(trackArray: [Track]) {
        
    }
    
    func didFetchWithFailure() {
        
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter : ChartViewOutput {
    func trackClicked(item: Track) {
        router.presentTrackDetails(track: item)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

//Mark: - ChartModuleOutput

extension ChartPresenter : ChartModuleOutput {
    var viewController: UIViewController {
        return view.viewController
    }
    
    func present() {
        view.present()
    }
}
