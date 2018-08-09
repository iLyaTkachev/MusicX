import UIKit

class ChartModule : ChartModuleInput {
    
    static func create() -> BaseModuleOutput {
        let router = ChartRouter()
        let presenter = ChartPresenter()
        let interactor = ChartInteractor()
        let view = Utils.getViewController(from: ChartViewController.storyboardId, with: ChartViewController.id) as! ChartViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.currentMediaType = .track
        
        return presenter
    }
}
