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
    
    var isLoading = false
    var currentPage = 0
    var currentMediaType: MediaType!
    
}

extension SearchPresenter : SearchInteractorOutput {
    func didFetchWithSuccess(media: [BaseMediaObject]) {
        print(media)
        view.hideActivityIndicator()
    }
    
    func didFetchWithFailure(error: CustomError) {
        view.hideActivityIndicator()
    }
    
}

extension SearchPresenter : SearchViewOutput {
    func search(with name: String) {
        view.showActivityIndicator()
        interactor.searchMedia(type: currentMediaType, name: name, page: 1)
    }
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.searchMedia(type: .track, name: "name", page: currentPage + 1)
    }
}
