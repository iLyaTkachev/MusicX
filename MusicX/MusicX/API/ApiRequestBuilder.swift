import Foundation

protocol BaseApiRequestBuilder {
    func getChart(mediaType: MediaType, page: Int?) -> URL?
    func search(type: MediaType, name: String, page: Int?) -> URL?
}

class ApiRequestBuilder : BaseApiRequestBuilder {
    
    private let lastFmBuilder: LastFmBuilder
    private let playmusBuilder: PlaymusBuilder
    
    init() {
        self.lastFmBuilder = LastFmBuilder()
        self.playmusBuilder = PlaymusBuilder()
    }
    
    func getChart(mediaType: MediaType, page: Int?) -> URL? {
        return lastFmBuilder.getChart(mediaType: mediaType, page: page)
    }
    
    func search(type: MediaType, name: String, page: Int?) -> URL? {
        switch type {
        case .track:
            return playmusBuilder.search(name: name, page: page)
        case .artist:
            return nil
        case .tag:
            return nil
        }
    }
    
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
