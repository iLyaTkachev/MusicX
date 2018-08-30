//
//  DownloadsPresenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class DownloadsPresenter {
    
    weak var view: DownloadsViewInput!
    var interactor: DownloadsInteractorInput!
    var router: DownloadsRouterInput!
}

extension DownloadsPresenter : DownloadsViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension DownloadsPresenter : DownloadsInteractorOutput {
    
}
