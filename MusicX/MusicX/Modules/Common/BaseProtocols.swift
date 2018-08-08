//
//  BaseContracts.swift
//  ViperTest
//
//  Created by Ilya Tkachou on 8/6/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseModuleInput: class {
    static func create() -> BaseModuleOutput
}

//presenter implements
protocol BaseModuleOutput : class {
    func present()
}

protocol BaseRouterInput : class{
    
}

protocol BaseViewInput: class, Presentable {
    func setupInitialState()
}

protocol BaseViewOutput: class {
    func viewIsReady()
}

protocol BaseInteractorInput: class{
    func fetch(contentType: MediaType, page: Int?)
}

protocol BaseInteractorOutput: class {

}
