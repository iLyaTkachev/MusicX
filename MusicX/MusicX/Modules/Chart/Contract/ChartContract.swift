//
//  ChartListContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import UIKit

protocol ChartModuleInput : BaseModuleInput {

}

protocol ChartModuleOutput : BaseModuleOutput {
    var viewController: UIViewController { get }
}

protocol ChartViewInput : BaseViewInput, ActivityIndicator {
    func updateList()
    func onError(message: String)
}

protocol ChartViewOutput : BaseViewOutput {
    var mediaCount: Int { get }
    var mediaType: MediaType { get }
    var cellIdentifier: String { get }
    func getMediaObject(forIndex: Int) -> BaseMediaObject
    func cellClicked(index: Int)
    func loadMedia(isReloading: Bool)
}

protocol ChartInteractorInput : BaseInteractorInput {

}

protocol ChartInteractorOutput : BaseInteractorOutput {
    func didFetchWithSuccess(chart: BaseChart)
    func didFetchWithFailure(error: CustomError)
}

protocol ChartRouterInput : BaseRouterInput {
    func presentMediaDetails(item: BaseMediaObject)
}
