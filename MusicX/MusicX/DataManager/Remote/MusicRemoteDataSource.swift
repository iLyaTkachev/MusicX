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
            
        queryService.executeRequest(urlToExecute: url) { (data, error) in
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
                completionHandler(nil, CustomError.requestError)
                return
            }
            guard let dict = data, let mediaArray = self.responseParser.parseMedia(type: type, data: dict) else {
                completionHandler(nil, CustomError.mediaParsing)
                return
            }
            result = Chart(type: type, page: page, items: mediaArray)
            completionHandler(result, nil)
        }
    }
    
    func searchMedia(type: MediaType, name: String, completionHandler: @escaping ([BaseMediaObject]?, CustomError?) -> Void) {
        queryService.executeRequest(urlToExecute: URL(string: "https://cool.dj")!) { (data, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            guard data != nil else {
                return
            }
            
            /*if let doc: Document = try? SwiftSoup.parse{
                print("\(try? doc.text())")
            }*/
            
            let doc = String(data: data!, encoding: .utf8)
            print(doc)
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
