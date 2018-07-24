import Foundation

protocol MusicDataSource {
    func getTopTracks() -> Void
}

final class MusicRepository: MusicDataSource {
    
    static let shared = MusicRepository()
    
    private let remoteDataSource: MusicRemoteDataSource
    private let localDataSource: MusicLocalDataSource
    
    private init() {
        remoteDataSource = MusicRemoteDataSource()
        localDataSource = MusicLocalDataSource()
    }
    
    func getTopTracks() {
        
    }
}
