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
        repository.getChart(type: contentType, page: page!) { (chart, error) in
            if error != nil {
                self.output.didFetchWithFailure(error: error!)
            } else if chart != nil{
                self.output.didFetchWithSuccess(chart: chart!)
            }
        }
    }
}
