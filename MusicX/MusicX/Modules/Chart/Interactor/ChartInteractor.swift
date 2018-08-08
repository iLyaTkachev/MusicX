//
//  Interactor.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class ChartInteractor : ChartInteractorInput {
    weak var output: ChartInteractorOutput!
    var repository: MusicDataSource!
    
    func fetch(contentType: MediaType, page: Int?) {
        
    }
}
