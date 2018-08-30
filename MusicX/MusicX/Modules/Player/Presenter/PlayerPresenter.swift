//
//  PlayerPresenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class PlayerPresenter {
    
    weak var view: PlayerViewInput!
    var interactor: PlayerInteractorInput!
    var router: PlayerRouterInput!
}

extension PlayerPresenter : PlayerViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension PlayerPresenter : PlayerInteractorOutput {
    
}
