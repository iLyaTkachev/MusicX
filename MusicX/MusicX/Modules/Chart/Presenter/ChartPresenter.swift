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
    
    var currentMediaType: MediaType = .track
    
    var isLoading = false
    var currentPage = 0
    
    
    private var items: [BaseMediaObject] = []

}

//Mark: - ChartInteractorOutput

extension ChartPresenter : ChartInteractorOutput {
    func didFetchWithSuccess(chart: BaseChart) {
        isLoading = false
        print("chart page fetched: \(chart.page)")
        if chart.type == currentMediaType, !chart.items.isEmpty {
            if chart.page == 1, currentPage > 1, !items.isEmpty {
                items = []
                currentPage = 1
            }
            
            currentPage = chart.page
            items += chart.items
            view.updateList(with: chart.items)
        }
        
        view.hideActivityIndicator()
        print("after fetching current: \(currentPage)")
    }
    
    func didFetchWithFailure(error: CustomError) {
        isLoading = false
        view.onError(message: error.errorDesctiption())
        view.hideActivityIndicator()
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter : ChartViewOutput {
    func loadMedia(isReloading: Bool = false) {
        guard isLoading else {
            isLoading = true
            
            if isReloading {
                interactor.fetch(contentType: currentMediaType, page: 1)
                print("start reloading")
            } else {
                interactor.fetch(contentType: currentMediaType, page: currentPage + 1)
                print("load media with page: \(currentPage+1)")
            }
            
            return
        }
    }
    
    var mediaCount: Int {
        return items.count
    }
    
    func getMediaObject(forIndex: Int) -> BaseMediaObject {
        return items[forIndex]
    }
    
    func itemClicked(item: BaseMediaObject) {
        router.presentMediaDetails(item: item)
    }
     
    func viewIsReady() {
        view.setupInitialState()
        view.showActivityIndicator()
        currentMediaType = .track
        loadMedia()
    }
}

//Mark: - ChartModuleOutput

extension ChartPresenter : ChartModuleOutput {
    var viewController: UIViewController {
        return view.viewController
    }
    
    func present() {
        view.present()
    }
}
