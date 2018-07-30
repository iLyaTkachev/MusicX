//
//  Presenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ChartPresenter<Item: Track, Interactor: ChartInteractorInput> : BasePresenter {
    var view: IndicatableView?
    
    var interactor: Interactor!
    
    var router: BaseRouter!
    
    func viewDidLoad() {
        
    }

}

extension ChartPresenter: ChartInteractorOutput {
    
    func didFetchWithSuccess(itemsArray: [Item]) {
        
    }
    
    func didFetchWithFailure() {
        
    }
    
    
}
