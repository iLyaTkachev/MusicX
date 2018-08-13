import Foundation

final class MusicRemoteDataSource: MusicDataSource {

    private let queryService: NetworkService
    //private let responseConverter: ResponseConverter
    
    init() {
        queryService = QueryService()
    }

    func getChart(type: MediaType, page: Int?) -> Chart? {
        switch type {
        case .track:
            return nil
        case .artist:
            return nil
        case .tag:
            return nil
        }
        /*if let url = ApiRequestBuilder.LastFmBuilder().getChart(mediaType: T.type, page: page){
        
        queryService.executeRequest(urlToExecute: url!) { (responseDict, error) in
            
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
            } else {
                guard let dict = responseDict?["tracks"] as? [String : Any] , let array = dict["track"] as? [Any] else {
                    print("Dictionary does not contain track key\n")
                    return
                }
                
                for trackDictionary in array {
                    if let trackDictionary = trackDictionary as? [String : Any],
                        let track = Track(with: trackDictionary) {
                        print(track.name + " " + track.listeners)
                    } else {
                        print("Problem parsing trackDictionary\n")
                        break
                    }
                }
                
            }
        }
        }*/
        return nil
    }
    
}
