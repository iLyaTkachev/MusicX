//
//  BaseContracts.swift
//  ViperTest
//
//  Created by Ilya Tkachou on 8/6/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation

protocol BaseModuleInput: class {
    func create() -> BaseModuleOutput
}

//presenter implements
protocol BaseModuleOutput : class {
    
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
    var output: BaseInteractorOutput! { get set } //weak
    func fetch(withUrl url: String)
}

protocol BaseInteractorOutput: class {

}
