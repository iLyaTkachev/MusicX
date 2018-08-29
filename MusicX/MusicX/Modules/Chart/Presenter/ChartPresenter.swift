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

extension ChartPresenter : ChartInteractorOutput {
    func didFetchWithSuccess(chart: BaseChart) {
        isLoading = false
        print("chart page fetched: \(chart.page)")
        if chart.type == requestedMediaType, !chart.items.isEmpty {
            if chart.page == 1, currentPage > 1, !items.isEmpty {
                items.removeAll()
                //currentPage = 1
            }
            
            currentMediaType = requestedMediaType
            currentPage = chart.page
            items += chart.items
            view.updateList()
            
            //print("Artists \(chart.page) ------------------------------------")
            //chart.items.forEach{ print("\($0.name)") }
        }
        
        view.hideActivityIndicator()
    }
    
    func didFetchWithFailure(error: CustomError) {
        isLoading = false
        view.onError(message: error.errorDesctiption())
        view.hideActivityIndicator()
        view.setType(type: currentMediaType)
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter : ChartViewOutput {
    func changeType(type: MediaType) {
        view.showActivityIndicator()
        
        DispatchQueue.main.async {
            self.items.removeAll()
            self.view.updateList()
        }
        
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
        case .tag ://TODO change
            return ""
        }
    }
    
    func loadMedia(isReloading: Bool = false) {
        guard isLoading else {
            isLoading = true
            
            if isReloading {
                interactor.fetch(contentType: requestedMediaType, page: 1)
            } else {
                interactor.fetch(contentType: requestedMediaType, page: currentPage + 1)
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
        router.presentMediaDetails(item: items[index])
    }
     
    func viewIsReady() {
        view.setupInitialState()
        view.showActivityIndicator()
        loadMedia()
    }
}
