import Foundation

class ApiRequestBuilder{
    
    class LastFmBuilder {
        
        func getChart(mediaType: MediaType, page: Int?) -> URL? {
            return buildJsonRequest(withMethod: ApiConstants.ApiComponents.Chart.chart + "." + mediaType.chartMethod(), withPage: page)
        }
        
        func buildJsonRequest(withMethod method: String, withPage: Int?) -> URL? {
            
            var url: URL?
            
            if var components = URLComponents(string: ApiConstants.ApiComponents.baseUrl) {
                components.path = "/\(ApiConstants.ApiComponents.version)/"
                components.queryItems = [URLQueryItem(name: ApiConstants.ApiComponents.method, value: method),
                                         URLQueryItem(name: ApiConstants.ApiComponents.apiKey, value: SecretConstants.apiKey),
                                         URLQueryItem(name: ApiConstants.ApiComponents.format, value: ApiConstants.ApiComponents.json)]
                
                if withPage != nil, withPage != 0 {
                    components.queryItems?.append(URLQueryItem(name: ApiConstants.ApiComponents.page, value: String(withPage!+1)))
                }
                
                url = components.url
            }
            
            return url
        }
    }
}
