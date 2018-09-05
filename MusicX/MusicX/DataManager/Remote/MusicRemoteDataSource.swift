import UIKit
import SwiftSoup

final class MusicRemoteDataSource: MusicDataSource {

    private let queryService: BaseNetworkService
    private let responseParser: BaseMediaResponseParser
    private let searchParser: BaseMediaResponseParser
    
    init(queryService: BaseNetworkService) {
        self.queryService = queryService
        responseParser = MediaResponseParser()
        searchParser = PlaymusSearchParser()
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
    
    func searchMedia(type: MediaType, name: String, page: Int?, completionHandler: @escaping ([BaseMediaObject]?, CustomError?) -> Void) {
        
        switch type {
        case .track:
            guard let url = ApiRequestBuilder.PlaymusBuilder().search(name: name, page: page) else {
                completionHandler(nil, CustomError.requestError)
                return
            }
        case .artist:
            completionHandler(nil, CustomError.requestError)
        case .tag:
            completionHandler(nil, CustomError.requestError)
        }
        
        guard let url = ApiRequestBuilder.PlaymusBuilder().search(name: name, page: page) else {
            completionHandler(nil, CustomError.requestError)
            return
        }
        
        queryService.executeRequest(urlToExecute: url) { (data, error) in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            guard data != nil else {
                return
            }
            
            let html = String(data: data!, encoding: .utf8)
            
            if let doc: Document = try? SwiftSoup.parse(html!){
                
                try? doc.getElementsByClass("ListTrack__item").forEach({ (link) in
                    print("\(try? link.attr("data-artist"))")
                    print("\(try? link.attr("data-name"))")
                    //print("\(try? link.child(1).attr("href"))")//link on mp3
                    //print("\(link.children().size())")
                    //print("\(link)")
                })
                
                
                
            }
            
            
            
            //let doc = String(data: data!, encoding: .utf8)
            //print(doc)
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
