import UIKit

final class MusicRemoteDataSource: MusicDataSource {

    private let queryService: BaseNetworkService
    private let responseParser: BaseMediaResponseParser
    private let imageService: BaseImageService
    
    init() {
        queryService = QueryService()
        responseParser = MediaResponseParser()
        imageService = ImageService(memoryCapacity: Constants.memoryCapacityForImageCache, diskCapacity: Constants.diskCapacityForImageCache, percentOfClearing: Constants.percentOfImageCacheClearing)
    }

    func getChart(type: MediaType, page: Int, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        var result: Chart?
        
        if let url = ApiRequestBuilder.LastFmBuilder().getChart(mediaType: type, page: page) {
            
            queryService.executeRequest(urlToExecute: url) { (responseDict, error) in

                if let unwrappedError = error {
                    print(unwrappedError.localizedDescription)
                    completionHandler(nil, CustomError.requestError)
                } else {
                    if let dict = responseDict {
                        //print(dict)
                        if let mediaArray = self.responseParser.parseMedia(type: type, dictionary: dict) {
                            result = Chart(type: type, page: page, items: mediaArray)
                            completionHandler(result, nil)
                        } else {
                            completionHandler(nil, CustomError.mediaParsing)
                        }
                    }
                }
            }
        }
    }
    
    func getImage(withUrl: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        imageService.getImage(withUrl: withUrl, completionHandler: completionHandler)
    }
    
}
