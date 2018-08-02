import UIKit

class ChartModule <ModuleInput: ChartModuleInput> : BaseModule {
    func create() -> ModuleInput {
        let router = ChartRouter()
        let presenter = ChartPresenter()
        let interactor = ChartInteractor()
        let viewController = R.storyboard.coinDetails.coinDetailsViewController()!
        
        interactor.output = presenter
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        return presenter
    }
}
