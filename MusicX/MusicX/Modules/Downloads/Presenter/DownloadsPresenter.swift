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
    
    var indexPathToDelete = IndexPath(row: 0, section: 0)
}

extension DownloadsPresenter: DownloadsViewOutput {
    func reloadData() {
        interactor.fetchDownloads()
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
    
    func deleteTrack(index: IndexPath) {
        indexPathToDelete = index
        interactor.deleteDownload(download: items[indexPathToDelete.row])
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension DownloadsPresenter: DownloadsInteractorOutput {
    
    func didFetchWithSuccess(response: [BaseMediaObject]) {
        items = response
        view.updateList()
        view.hideActivityIndicator()
        
        if items.isEmpty {
            view.showEmptyLabel()
        }
    }
    
    func didFetchWithFailure(error: CustomError) {
        view.hideActivityIndicator()
        view.onError(message: error.errorDesctiption())
    }
    
    func didDeleteWithSuccess() {
        items.remove(at: indexPathToDelete.row)
        view.deleteRow(atIndex: indexPathToDelete)
    }
    
    func didDeleteWithFailure(error: CustomError) {
        view.onError(message: error.errorDesctiption())
    }
}
