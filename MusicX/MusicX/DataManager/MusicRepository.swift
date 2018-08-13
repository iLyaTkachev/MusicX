import Foundation

final class MusicRepository: MusicDataSource {

    static let shared = MusicRepository()
    
    private let remoteDataSource: MusicDataSource
    private let localDataSource: MusicDataSource
    
    private init() {
        remoteDataSource = MusicRemoteDataSource()
        localDataSource = MusicLocalDataSource()
    }
    
    func getChart(type: MediaType, page: Int?, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        return remoteDataSource.getChart(type: type, page: page, completionHandler: completionHandler)
    }
}
