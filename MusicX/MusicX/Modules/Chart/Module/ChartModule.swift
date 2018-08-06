import UIKit

class ChartModule : BaseModuleInput {
    func create() -> BaseModuleOutput {
        let router = ChartRouter()
        let presenter = ChartPresenter()
        let interactor = ChartInteractor()
        let viewController = Utils.getViewController(from: ChartViewController.storyboardId, with: ChartViewController.id) as! ChartViewController
        
        interactor.output = presenter
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        return presenter
    }
}
