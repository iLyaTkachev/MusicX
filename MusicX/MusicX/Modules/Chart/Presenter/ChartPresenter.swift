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
    func didFetchWithSuccess(itemsArray: [BaseMediaObject]) {
        /*if itemsArray == currentMediaType {
            view.updateList(with: itemsArray)
        }*/
    }
    
    func didFetchWithSuccess<T: BaseMediaObject>(itemsArray: [T]) {
        if T.type == currentMediaType {
            view.updateList(with: itemsArray)
        }
    }
    
    func didFetchWithFailure() {
        view.onError()
    }
}

//Mark: - ChartViewOutput

extension ChartPresenter : ChartViewOutput {
    func itemClicked(item: BaseMediaObject) {
        router.presentMediaDetails(item: item)
    }
    
    func viewIsReady() {
        interactor.fetch(contentType: .track, page: 1)
        view.setupInitialState()
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
