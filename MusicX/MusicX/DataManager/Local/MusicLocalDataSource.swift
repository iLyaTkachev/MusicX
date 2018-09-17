import UIKit

class MusicLocalDataSource: MusicDataSource {

    private let coreDataManager: BaseCoreDataManager
    
    init(coreDataManager: BaseCoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (ChartResponse?, CustomError?)->Void) {
        completionHandler(nil, nil)
    }
    
    func searchMedia(type: MediaType, name: String, page: Int, completionHandler: @escaping (SearchResponse?, CustomError?) -> Void) {
        
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
    }
    
    func getImageDirectorySize() -> Int {
        return 0
    }
    
    func clearImageDirectory() {
        
    }
}
