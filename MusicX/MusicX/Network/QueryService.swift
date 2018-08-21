import Foundation

protocol BaseNetworkService {
    func executeRequest(urlToExecute : URL, completionHandler: @escaping ([String: Any]?, Error?)->Void)
}

class QueryService: BaseNetworkService {
    
    private let defaultSession = URLSession(configuration: .default)
    
    func executeRequest(urlToExecute : URL, completionHandler: @escaping ([String: Any]?, Error?)->Void) {
        
        let webRequest = URLRequest(url: urlToExecute)
        
        let dataTask = defaultSession.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
            
            guard let unwrappedData = webData else {
                completionHandler(nil, apiError)
                print(apiError!)
                return
            }
            
            do {
                let jsonResponse = try Utils.dataToJson(data: unwrappedData) as? [String: Any]
                completionHandler(jsonResponse, nil)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil, error)
            }
        }
        
        dataTask.resume()
    }
    
}
