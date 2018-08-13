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

protocol ChartViewInput : BaseViewInput {
    func updateList(with array: [BaseMediaObject])
    func onError()
}

protocol ChartViewOutput : BaseViewOutput {
    func itemClicked(item: BaseMediaObject)
}

protocol ChartInteractorInput : BaseInteractorInput {

}

protocol ChartInteractorOutput : BaseInteractorOutput {
    func didFetchWithSuccess(chart: Chart)
    func didFetchWithFailure()
}

protocol ChartRouterInput : BaseRouterInput {
    func presentMediaDetails(item: BaseMediaObject)
}
