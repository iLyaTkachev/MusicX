import UIKit

final class MusicRemoteDataSource: MusicDataSource {

    private let queryService: BaseNetworkService
    private let responseParser: BaseMediaResponseParser
    
    init(queryService: BaseNetworkService) {
        self.queryService = queryService
        responseParser = MediaResponseParser()
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        var result: Chart?
        
        guard let url = ApiRequestBuilder.LastFmBuilder().getChart(mediaType: type, page: page) else {
            completionHandler(nil, nil)
            return
        }
            
        queryService.executeRequest(urlToExecute: url) { (responseDict, error) in
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
                completionHandler(nil, CustomError.requestError)
                return
            }
            guard let dict = responseDict, let mediaArray = self.responseParser.parseMedia(type: type, dictionary: dict) else {
                completionHandler(nil, CustomError.mediaParsing)
                return
            }
            result = Chart(type: type, page: page, items: mediaArray)
            completionHandler(result, nil)
        }
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
    }
    
    func getImageDirectorySize() -> Int {
        return 0
    }
    
    func clearImageDirectory() {
        
    }
}
