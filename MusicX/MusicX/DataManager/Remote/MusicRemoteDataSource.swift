import UIKit
import SwiftSoup

final class MusicRemoteDataSource: MusicDataSource {

    private let requestBuilder: BaseApiRequestBuilder
    private let queryService: BaseNetworkService
    private let responseParser: BaseMediaResponseParser
    private let searchParser: BaseMediaResponseParser
    
    init(queryService: BaseNetworkService) {
        self.requestBuilder = ApiRequestBuilder()
        self.queryService = queryService
        responseParser = MediaResponseParser()
        searchParser = PlaymusSearchParser()
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (ChartResponse?, CustomError?)->Void) {
        guard let url = requestBuilder.getChart(mediaType: type, page: page) else {
            completionHandler(nil, CustomError.apiError)
            return
        }
        
        queryService.executeRequest(urlToExecute: url) { (data, error) in
            guard error == nil else {
                completionHandler(nil, CustomError.requestError)
                return
            }

            guard let dict = data, let mediaArray = self.responseParser.parseMedia(type: type, data: dict) else {
                completionHandler(nil, CustomError.mediaParsing)
                return
            }
            
            let result = ChartResponse(type: type, page: page, items: mediaArray)
            completionHandler(result, nil)
        }
    }
    
    func searchMedia(type: MediaType, name: String, page: Int, completionHandler: @escaping (SearchResponse?, CustomError?) -> Void) {
        guard let url = requestBuilder.search(type: type, name: name, page: page) else {
            completionHandler(nil, CustomError.apiError)
            return
        }
        
        queryService.executeRequest(urlToExecute: url) { (data, error) in
            guard error == nil else {
                completionHandler(nil, CustomError.requestError)
                return
            }
            
            guard data != nil, let items = self.searchParser.parseMedia(type: .track, data: data!) else {
                completionHandler(nil, CustomError.mediaParsing)
                return
            }
            
            let result = SearchResponse(type: type, searchName: name, page: page, items: items)
            completionHandler(result, nil)
        }
    }
    
    func createPlaylist(name: String) {
        
    }
    
    func getPlaylists(completionHandler: @escaping (PlaylistsResponse?, CustomError?) -> Void) {
        
    }
    
    func addTrackToPlaylist(track: Track, playlist: Playlist) {
        
    }
    
    func deleteTrackFromPlaylist(track: Track, playlist: Playlist) {
        
    }
    
    func downloadTrack(download: Download) {
        
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
    }
    
    func getImageDirectorySize() -> Int {
        return 0
    }
    
    func clearImageDirectory() {
        
    }
}
