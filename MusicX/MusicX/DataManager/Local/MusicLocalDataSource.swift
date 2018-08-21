import UIKit

class MusicLocalDataSource: MusicDataSource {

    init() {
        
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        completionHandler(nil, nil)
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
    }
}
