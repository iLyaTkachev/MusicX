//
//  Presenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ChartPresenter {
    weak var view: ChartViewInput!
    var interactor: ChartInteractorInput!
    var router: ChartRouterInput!
    
    private var tracks: [Track] = []

}

extension ChartPresenter : ChartInteractorOutput {
    func didFetchWithSuccess(trackArray: [Track]) {
        
    }
    
    func didFetchWithFailure() {
        
    }
}

extension ChartPresenter : ChartViewOutput {
    func trackClicked(item: Track) {
        
    }
    
    func viewIsReady() {
        
    }
}

extension ChartPresenter : ChartModuleOutput {
    func present() {
        
    }
    
    
}
