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
        
        var result: [BaseMediaObject]?
        
        switch contentType {
        case .track:
            if let arr:[Track] = repository.getChart(page: page){
                result = arr
            }
        case .artist:
            if let arr:[Artist] = repository.getChart(page: page){
                result = arr
            }
        case .tag:
            //TODO: change on Tag
            if let arr:[Artist] = repository.getChart(page: page){
                result = arr
            }
        }
        
        if result != nil {
            output.didFetchWithSuccess(itemsArray: result!)
        } else {
            output.didFetchWithFailure()
        }
    }
}
