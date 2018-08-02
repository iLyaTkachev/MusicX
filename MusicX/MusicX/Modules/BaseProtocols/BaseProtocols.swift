import Foundation
import UIKit

protocol BaseModule {
    associatedtype ModuleInput: BaseModuleInput
    
    func create() -> ModuleInput
}

protocol BaseModuleInput {
    associatedtype ModuleOutput: BaseModuleOutput
    
    var output: ModuleOutput? { get set }
}

protocol BaseModuleOutput {
    
}

protocol BaseViewInput: class {
    func setupInitialState()
}

protocol BaseViewOutput {
    func viewIsReady()
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
    associatedtype Router: BaseRouter
    
    var view: View? { get } //Should be weak
    var interactor: Interactor! { get }
    var router: Router! { get }
    
    func viewDidLoad()
}

protocol BaseRouter: class {
    associatedtype Item

    func presentSend(for item: Item, from: UIViewController)
    func presentReceive(for item: Item, from: UIViewController)
}
