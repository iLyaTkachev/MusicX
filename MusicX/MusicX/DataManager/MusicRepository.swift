import Foundation

protocol MusicDataSource {
    func getTopTracks() -> [MediaObject]?
}

final class MusicRepository: MusicDataSource {
    
    static let shared = MusicRepository()
    
    
    private let remoteDataSource: MusicDataSource
    private let localDataSource: MusicDataSource
    
    private init() {
        remoteDataSource = MusicRemoteDataSource()
        localDataSource = MusicLocalDataSource()
    }
    
    func getTopTracks() -> [MediaObject]? {
        return nil
    }
}
