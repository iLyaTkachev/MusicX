import Foundation

final class MusicRemoteDataSource: MusicDataSource {
    
    private let queryService: NetworkService
    
    init() {
        queryService = QueryService()
    }
    
    func getTopTracks() -> [MediaObject]? {
        return nil
    }
    
}
