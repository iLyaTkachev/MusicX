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
    
    private var items: [BaseMediaObject] = []

}

//Mark: - ChartInteractorOutput

extension ChartPresenter : ChartInteractorOutput {
    func didFetchWithSuccess(chart: BaseChart) {
        if chart.type == currentMediaType && chart.items != nil{
            view.updateList(with: chart.items!)
            view.hideActivityIndicator()
        }
    }
    
    func didFetchWithFailure(error: CustomError) {
        view.onError(message: error.errorDesctiption())
        view.hideActivityIndicator()
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter : ChartViewOutput {
    func itemClicked(item: BaseMediaObject) {
        router.presentMediaDetails(item: item)
    }
    
    func viewIsReady() {
        view.setupInitialState()
        view.showActivityIndicator()
        interactor.fetch(contentType: .track, page: 1)
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
