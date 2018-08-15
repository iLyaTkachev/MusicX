import Foundation

class MusicLocalDataSource: MusicDataSource {

    init() {
        
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        completionHandler(nil, nil)
    }
}
