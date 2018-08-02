//
//  ChartListContract.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol ChartViewInput: BaseViewInput, Presentable {
    func updateList(with array: [MediaObject])
}

protocol ChartViewOutput: BaseViewOutput {
    func trackClicked(item: MediaObject)
}

protocol ChartInteractorInput: BaseInteractorInput {
    //methods in Interactor, which called by Presenter
}

protocol ChartInteractorOutput: BaseInteractorOutput {
    //methods that presenter implements and Interactor calls
}

protocol ChartRouterInput: BaseRouter {
    
}
