import UIKit

class ChartAssembly {
    
    static func create() -> ChartViewInput {
        let router = ChartRouter()
        let interactor = ChartInteractor()
        let presenter = ChartPresenter()
        let view = Utils.getViewController(storyboardName: ChartViewController.storyboardName, vcId: ChartViewController.vcId) as! ChartViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        view.cellBuider = ChartCellBuilder()
        view.tableVC = UniversalTableViewController()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.currentMediaType = .track
        presenter.requestedMediaType = .track
        
        return view
    }
}
