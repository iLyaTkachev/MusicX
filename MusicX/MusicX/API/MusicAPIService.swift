import Foundation

class MusicAPIService {
    
    func executeWebRequest(urlToExecute : URL, completionHandler: @escaping ([String : Any]?, Error?)->Void) {
        
        let sharedSession = URLSession.shared
        let webRequest = URLRequest(url: urlToExecute)
        
        let dataTask = sharedSession.dataTask(with: webRequest) { (webData, urlRespose, apiError) in
            
            guard let unwrappedData = webData else {
                completionHandler(nil, apiError)
                print(apiError!)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String : Any]
                completionHandler(jsonResponse, nil)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil, error)
            }
        }
        
        dataTask.resume()
    }
}
