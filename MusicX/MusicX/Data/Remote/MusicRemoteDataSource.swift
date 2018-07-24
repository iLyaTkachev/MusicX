import Foundation

final class MusicRemoteDataSource: MusicDataSource {
    
    private let queryService: QueryService
    
    init() {
        queryService = QueryService()
    }
    
    func getTopTracks() {
    
    }
    
}
