//
//  Presenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ChartPresenter<Item: Track, Interactor: ChartInteractorInput, View: ChartViewInput, Router: ChartRouterInput> : BasePresenter {
    private(set) weak var view: View?
    private(set) var interactor: Interactor!
    private(set) var router: Router!
    
    private var tracks: [Item] = []
    
    func viewDidLoad() {
        
    }

}

extension ChartPresenter: ChartInteractorOutput {
    
    func didFetchWithSuccess(itemsArray: [Item]) {
        
    }
    
    func didFetchWithFailure() {
        
    }
    
}

extension ChartPresenter: ChartViewOutput {
    func trackClicked(item: MediaObject) {
        
    }
    
    func viewIsReady() {
        
    }
    
    
}
