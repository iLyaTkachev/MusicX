import Foundation

class ApiRequestBuilder{
    
    class LastFmBuilder {
        
        func buildJsonRequest(withMethod method: String) -> URL? {
            
            var url: URL?
            
            if var components = URLComponents(string: Constants.ApiComponents.baseUrl) {
                components.path = "/\(Constants.ApiComponents.version)/"
                components.queryItems = [URLQueryItem(name: Constants.ApiComponents.method, value: method),
                                   URLQueryItem(name: Constants.ApiComponents.apiKey, value: SecretConstants.apiKey),
                                   URLQueryItem(name: Constants.ApiComponents.format, value: Constants.ApiComponents.json)]
                url = components.url
            }
            
            return url
        }
    }
}
