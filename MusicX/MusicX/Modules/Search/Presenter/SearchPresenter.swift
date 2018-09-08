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
    
    private var items: [BaseMediaObject] = []
    private var requestedName = ""
}

extension SearchPresenter : SearchInteractorOutput {
    func didFetchWithSuccess(media: [BaseMediaObject]) {
        if <#condition#> {
            <#code#>
        }
        items = media
        view.updateList()
        view.hideActivityIndicator()
    }
    
    func didFetchWithFailure(error: CustomError) {
        view.hideActivityIndicator()
        view.onError(message: error.errorDesctiption())
    }
    
}

extension SearchPresenter : SearchViewOutput {
    var mediaType: MediaType {
        return currentMediaType
    }
    
    var mediaCount: Int {
        return items.count
    }
    
    var cellIdentifier: String {
        return SearchTrackCell.identifier
    }
    
    func getMediaObject(forIndex: Int) -> BaseMediaObject? {
        guard forIndex < items.count else {
            return nil
        }
        
        return items[forIndex]
    }
    
    func cellClicked(index: Int) {
        print("cell clicked")
    }
    
    func search(with name: String) {
        view.showActivityIndicator()
        requestedName = name
        
        DispatchQueue.main.async {
            self.items.removeAll()
            self.view.updateList()
        }
        
        interactor.searchMedia(type: currentMediaType, name: name, page: 1)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}
