import Foundation

class ApiRequestBuilder{
    
    class LastFmBuilder {
        
        func buildJsonRequest(withMethod method: String, withPage: Int?) -> URL? {
            
            var url: URL?
            
            if var components = URLComponents(string: Constants.ApiComponents.baseUrl) {
                components.path = "/\(Constants.ApiComponents.version)/"
                components.queryItems = [URLQueryItem(name: Constants.ApiComponents.method, value: method),
                                         URLQueryItem(name: Constants.ApiComponents.apiKey, value: SecretConstants.apiKey),
                                         URLQueryItem(name: Constants.ApiComponents.format, value: Constants.ApiComponents.json)]
                
                if (withPage != nil) {
                    components.queryItems?.append(URLQueryItem(name: Constants.ApiComponents.page, value: String(withPage!)))
                }
                
                url = components.url
            }
            
            return url
        }
    }
}
