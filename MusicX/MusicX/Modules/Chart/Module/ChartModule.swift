import UIKit

class ChartModule <ModuleInput: ChartModuleInput> : BaseModule {
    func create() -> ModuleInput {
        let router = ChartRouter()
        let presenter = ChartPresenter()
        let interactor = ChartInteractor()
        let viewController = Utils.getViewController(from: ChartViewController.storyboardId, with: ChartViewController.id)
        
        interactor.output = presenter
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        return presenter
    }
}
