import Foundation

final class MusicRemoteDataSource: MusicDataSource {

    private let queryService: NetworkService
    private let responseParser: MediaParser
    
    init() {
        queryService = QueryService()
        responseParser = ResponseParser()
    }

    func getChart(type: MediaType, page: Int?, completionHandler: @escaping (Chart?, CustomError?)->Void) {
        var result: Chart?
        
        if let url = ApiRequestBuilder.LastFmBuilder().getChart(mediaType: type, page: page) {
            
            queryService.executeRequest(urlToExecute: url) { (responseDict, error) in

                if let unwrappedError = error {
                    print(unwrappedError.localizedDescription)
                    completionHandler(nil, CustomError.requestError)
                } else {
                    if let dict = responseDict {
                        if let mediaArray = self.responseParser.parseMedia(type: type, dictionary: dict) {
                            result = Chart(type: type, items: mediaArray)
                            completionHandler(result, nil)
                        } else {
                            completionHandler(nil, CustomError.mediaParsing)
                        }
                    }
                }
            }
        }
    }
    
}
