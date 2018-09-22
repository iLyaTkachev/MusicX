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
    
    private var items: [BaseMediaObject] = []
}

extension DownloadsPresenter: DownloadsViewOutput {
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
    
    func deleteTrack(index: Int) {
        
    }
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetchTracks()
    }
}

extension DownloadsPresenter: DownloadsInteractorOutput {
    func didFetchWithSuccess(response: [BaseMediaObject]) {
        items = response
        view.updateList()
        
        if items.isEmpty {
            view.onError(message: "No results")
        }
    }
    
    func didFetchWithFailure(error: CustomError) {
        view.onError(message: "Error")
    }
    
    
}
