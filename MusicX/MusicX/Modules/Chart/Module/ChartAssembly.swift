import UIKit

class ChartAssembly {
    
    static func create() -> ChartViewInput {
        let router = ChartRouter()
        let presenter = ChartPresenter()
        let interactor = ChartInteractor()
        let view = Utils.getViewController(storyboardName: ChartViewController.storyboardId, vcId: ChartViewController.id) as! ChartViewController
        
        interactor.output = presenter
        interactor.repository = CoreX.shared.repository
        
        view.output = presenter
        view.cellBuider = ChartCellBuilder()
        view.tableVC = UniversalTableViewController()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.currentMediaType = .track
        
        return view
    }
}
