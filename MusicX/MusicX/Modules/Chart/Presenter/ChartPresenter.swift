//
//  Presenter.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

class ChartPresenter {
    weak var view: ChartViewInput!
    var interactor: ChartInteractorInput!
    var router: ChartRouterInput!
    
    var currentMediaType: MediaType!
    var requestedMediaType: MediaType!
    
    var isLoading = false
    var currentPage = 0
    
    private var items: [BaseMediaObject] = []

}

//Mark: - ChartInteractorOutput

extension ChartPresenter: ChartInteractorOutput {
    func didFetchWithSuccess(chart: BaseMediaResponse) {
        isLoading = false
        print("\(chart.page)")
        if chart.type == requestedMediaType, !chart.items.isEmpty {
            if chart.page == 1, currentPage > 1, !items.isEmpty {
                items.removeAll()
                currentMediaType = requestedMediaType
                currentPage = chart.page
                items += chart.items
                view.updateList(paths: nil)
            } else {
            let rowsCount = items.count
            let newRows = chart.items.count
            
            let paths = (rowsCount..<rowsCount + newRows).map{IndexPath(row: $0, section: 0)}
            currentMediaType = requestedMediaType
            currentPage = chart.page
            items += chart.items
            view.updateList(paths: paths)
            }
        }
        
        view.hideActivityIndicator()
    }
    
    func didFetchWithFailure(error: CustomError) {
        isLoading = false
        view.onError(message: error.errorDesctiption())
        view.hideActivityIndicator()
        view.setType(type: currentMediaType)
        view.updateList(paths: nil)
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter: ChartViewOutput {
    func changeType(type: MediaType) {
        view.showActivityIndicator()
        
        DispatchQueue.main.async {
            self.items.removeAll()
            self.view.updateList(paths: nil)
        }
        
        currentMediaType = type
        requestedMediaType = type
        print("\(requestedMediaType.rawValue)")
        loadMedia(isReloading: true)
    }
    
    var mediaType: MediaType {
        return currentMediaType
    }
    
    var cellIdentifier: String {
        switch mediaType {
        case .track :
            return ChartTrackCell.identifier
        case .artist :
            return ChartArtistCell.identifier
        case .tag :
            return ChartTagCell.identifier
        }
    }
    
    func loadMedia(isReloading: Bool = false) {
        guard isLoading else {
            isLoading = true
            
            if isReloading {
                interactor.fetch(contentType: requestedMediaType, page: 1)
            } else {
                guard requestedMediaType == .tag else {
                    interactor.fetch(contentType: requestedMediaType, page: currentPage + 1)
                    return
                }
                
                isLoading = false
            }
            
            return
        }
    }
    
    var mediaCount: Int {
        return items.count
    }
    
    func getMediaObject(forIndex: Int) -> BaseMediaObject? {
        guard forIndex < items.count else {
            return nil
        }
        
        return items[forIndex]
    }
    
    func cellClicked(index: Int) {
        switch currentMediaType as MediaType {
        case .track:
            guard let track = items[index] as? Track else {
                break
            }
            router.playTrack(track: track)
        case .artist:
            guard let artist = items[index] as? Artist else {
                break
            }
            router.presentArtistDetails(artist: artist)
        case .tag:
            break
        }
    }
     
    func viewIsReady() {
        view.setupInitialState()
        view.showActivityIndicator()
        loadMedia()
    }
}
