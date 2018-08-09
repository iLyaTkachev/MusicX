import Foundation

class MusicLocalDataSource: MusicDataSource {

    init() {
        
    }

    func getChart<T: BaseMediaObject>(page: Int?) -> [T]? {
        return nil
    }
}
