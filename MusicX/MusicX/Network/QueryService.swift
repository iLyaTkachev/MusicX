import Foundation

protocol BaseNetworkService {
    func executeRequest(urlToExecute: URL, completionHandler: @escaping (Data?, Error?)->Void)
}

class QueryService: BaseNetworkService {
    
    private let defaultSession = URLSession(configuration: .default)
    
    func executeRequest(urlToExecute: URL, completionHandler: @escaping (Data?, Error?)->Void) {
        
        let webRequest = URLRequest(url: urlToExecute)
        
        let dataTask = defaultSession.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
            
            guard let unwrappedData = webData else {
                completionHandler(nil, apiError)
                print(apiError!)
                return
            }

            completionHandler(unwrappedData, nil)
        }
        
        dataTask.resume()
    }
    
}
