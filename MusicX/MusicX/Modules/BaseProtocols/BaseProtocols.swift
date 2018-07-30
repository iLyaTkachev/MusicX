//
//  BaseProtocols.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation
import UIKit

protocol IndicatableView: class {
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol BaseInteractorInput: class {
    associatedtype Output: BaseInteractorOutput
    
    var output: Output! { get set } //For Presenters, should be weak
    func fetch(withUrl url: String)
}

protocol BaseInteractorOutput: class {
    associatedtype Item
    
    func didFetchWithSuccess(itemsArray: [Item])
    func didFetchWithFailure()
}

protocol BasePresenter: class {
    associatedtype Interactor: BaseInteractorInput
    
    var view: IndicatableView? { get set } //Should be weak
    var interactor: Interactor! { get set }
    var router: BaseRouter! { get set }
    
    func viewDidLoad()
}

protocol BaseRouter: class {
    
    var viewController: UIViewController? { get set }//Should be weak
    static func assembleModule() -> UIViewController
}
