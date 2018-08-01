//
//  BaseProtocols.swift
//  MusicX
//
//  Created by Ilya Tkachou on 7/30/18.
//  Copyright © 2018 Ilya Tkachou. All rights reserved.
//

import Foundation
import UIKit

// VIPER protocols {

protocol BaseViewInput: class {
    func setupInitialState()
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
    associatedtype View: BaseViewInput, Presentable
    
    var view: View? { get } //Should be weak
    var interactor: Interactor! { get }
    var router: BaseRouter! { get }
    
    func viewDidLoad()
}

protocol BaseRouter: class {
    
    var viewController: UIViewController? { get set }//Should be weak
    
    
    static func assembleModule() -> UIViewController
}

// } VIPER protocols

protocol Presentable {
    
    var viewController: UIViewController { get }
    
    func present()
    func present(fromViewController viewController: UIViewController)
    func presentModal(fromViewController viewController: UIViewController)
    func show(fromViewController viewController: UIViewController)
    func dissmiss()
    func dissmissModal()
    func popToRoot()
}


extension Presentable where Self: UIViewController {
    
    var viewController: UIViewController {
        return self
    }
    
    func present() {
        AppDelegate.currentWindow.rootViewController = viewController
    }
    
    func present(fromViewController viewController: UIViewController) {
        viewController.navigationController?.pushViewController(self, animated: true)
    }
    
    func presentModal(fromViewController viewController: UIViewController) {
        viewController.present(self, animated: true, completion: nil)
    }
    
    func show(fromViewController viewController: UIViewController) {
        viewController.show(self, sender: viewController)
    }
    
    func dissmiss() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func dissmissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func popToRoot() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}

