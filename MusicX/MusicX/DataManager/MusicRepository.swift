import Foundation

final class MusicRepository: MusicDataSource {

    static let shared = MusicRepository()
    
    private let remoteDataSource: MusicDataSource
    private let localDataSource: MusicDataSource
    
    private init() {
        remoteDataSource = MusicRemoteDataSource()
        localDataSource = MusicLocalDataSource()
    }
    
    func getChart(type: MediaType, page: Int?) -> Chart? {
        return remoteDataSource.getChart(type: type, page: page)
    }
}
