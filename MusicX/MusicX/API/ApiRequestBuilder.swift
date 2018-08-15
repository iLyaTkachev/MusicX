import Foundation

class ApiRequestBuilder{
    
    class LastFmBuilder {
        
        func getChart(mediaType: MediaType, page: Int?) -> URL? {
            return buildJsonRequest(withMethod: Constants.ApiComponents.Chart.chart + "." + mediaType.chartMethod(), withPage: page)
        }
        
        func buildJsonRequest(withMethod method: String, withPage: Int?) -> URL? {
            
            var url: URL?
            
            if var components = URLComponents(string: Constants.ApiComponents.baseUrl) {
                components.path = "/\(Constants.ApiComponents.version)/"
                components.queryItems = [URLQueryItem(name: Constants.ApiComponents.method, value: method),
                                         URLQueryItem(name: Constants.ApiComponents.apiKey, value: SecretConstants.apiKey),
                                         URLQueryItem(name: Constants.ApiComponents.format, value: Constants.ApiComponents.json)]
                
                if withPage != nil, withPage != 0 {
                    components.queryItems?.append(URLQueryItem(name: Constants.ApiComponents.page, value: String(withPage!+1)))
                }
                
                url = components.url
            }
            
            return url
        }
    }
}
