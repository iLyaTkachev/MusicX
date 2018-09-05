import Foundation

class ApiRequestBuilder{
    
    class LastFmBuilder {
        
        func getChart(mediaType: MediaType, page: Int?) -> URL? {
            return buildJsonRequest(withMethod: ApiConstants.LastFmApi.Chart.chart + "." + mediaType.chartMethod(), withPage: page)
        }
        
        func buildJsonRequest(withMethod method: String, withPage: Int?) -> URL? {
            
            var url: URL?
            
            if var components = URLComponents(string: ApiConstants.LastFmApi.baseUrl) {
                components.path = "/\(ApiConstants.LastFmApi.version)/"
                components.queryItems = [URLQueryItem(name: ApiConstants.LastFmApi.method, value: method),
                                         URLQueryItem(name: ApiConstants.LastFmApi.apiKey, value: SecretConstants.apiKey),
                                         URLQueryItem(name: ApiConstants.LastFmApi.format, value: ApiConstants.LastFmApi.json)]
                
                if withPage != nil, withPage != 0 {
                    components.queryItems?.append(URLQueryItem(name: ApiConstants.LastFmApi.page, value: String(withPage!+1)))
                }
                
                url = components.url
            }
            
            return url
        }
    }
    
    class PlaymusBuilder {
        func search(name: String, page: Int?) -> URL? {
            
            var url: URL?
            
            if var components = URLComponents(string: ApiConstants.PlaymusApi.baseUrl) {
                components.path = "/\(ApiConstants.PlaymusApi.search)/\(name)/\(page != nil ? page! : 1)"
                
                url = components.url
            }
            
            return url
        }
    }
}
