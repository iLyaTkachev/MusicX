//
//  Interactor.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ChartInteractor <Presenter: ChartInteractorOutput> : ChartInteractorInput {

    weak var output: Presenter!
    
    func fetch(withUrl url: String) {
        
    }
    
}
