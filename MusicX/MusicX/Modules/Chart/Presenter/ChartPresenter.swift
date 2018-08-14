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
    
    var currentMediaType: MediaType?
    
    var isLoading = false
    var currentPage = 1
    
    
    private var items: [BaseMediaObject] = []

}

//Mark: - ChartInteractorOutput

extension ChartPresenter : ChartInteractorOutput {
    func didFetchWithSuccess(chart: BaseChart) {
        isLoading = false
        
        if chart.type == currentMediaType && chart.items != nil{
            items += chart.items!
            view.updateList(with: chart.items!)
            view.hideActivityIndicator()
        }
    }
    
    func didFetchWithFailure(error: CustomError) {
        isLoading = false
        view.onError(message: error.errorDesctiption())
        view.hideActivityIndicator()
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter : ChartViewOutput {
    func loadMedia() {
        guard isLoading else {
            isLoading = true
            interactor.fetch(contentType: currentMediaType!, page: currentPage)
            currentPage+=1
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
