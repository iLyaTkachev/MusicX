import Foundation

final class MusicRepository: MusicDataSource {

    static let shared = MusicRepository()
    
    private let remoteDataSource: MusicDataSource
    private let localDataSource: MusicDataSource
    
    private init() {
        remoteDataSource = MusicRemoteDataSource()
        localDataSource = MusicLocalDataSource()
    }
    
    func getChart<T: BaseMediaObject>(page: Int?) -> [T]? {
        return remoteDataSource.getChart(page: page)
    }
}
