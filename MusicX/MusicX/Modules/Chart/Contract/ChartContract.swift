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
    func updateList(with array: [Track])
}

protocol ChartViewOutput : BaseViewOutput {
    func trackClicked(item: Track)
}

protocol ChartInteractorInput : BaseInteractorInput {

}

protocol ChartInteractorOutput : BaseInteractorOutput {
    func didFetchWithSuccess(trackArray: [Track])
    func didFetchWithFailure()
}

protocol ChartRouterInput : BaseRouterInput {
    func presentTrackDetails(track: Track)
}
