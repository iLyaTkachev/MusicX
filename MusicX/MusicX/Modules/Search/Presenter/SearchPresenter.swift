//
//  SearchPresenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 8/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

class SearchPresenter {
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!
}

extension SearchPresenter : SearchInteractorOutput {
    func didFetchWithSuccess(media: [BaseMediaObject]) {
        
    }
    
    func didFetchWithFailure(error: CustomError) {
        
    }
    
    
}

extension SearchPresenter : SearchViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.searchMedia(type: .track, name: "name")
    }
}
