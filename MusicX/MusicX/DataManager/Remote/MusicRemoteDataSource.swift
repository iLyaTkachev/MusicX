import Foundation

final class MusicRemoteDataSource: MusicDataSource {

    private let queryService: NetworkService
    private let responseParser: MediaParser
    
    init() {
        queryService = QueryService()
        responseParser = ResponseParser()
    }

    func getChart(type: MediaType, page: Int?) -> Chart? {
        var result: Chart?
        
        if let url = ApiRequestBuilder.LastFmBuilder().getChart(mediaType: type, page: page) {
            
            queryService.executeRequest(urlToExecute: url) { (responseDict, error) in
                print(Utils.currentQueueName())
                if let unwrappedError = error {
                    print(unwrappedError.localizedDescription)
                } else {
                    if responseDict != nil {
                        if let mediaArray = self.responseParser.parseMedia(type: type, dictionary: responseDict!) {
                            result = Chart(type: type, items: mediaArray)
                        }
                    }
                }
            }
        }
        return result
    }
    
}
