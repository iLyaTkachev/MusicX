import Foundation

class Artist: Codable {
    let name, mbid, url: String
    
    init(name: String, mbid: String, url: String) {
        self.name = name
        self.mbid = mbid
        self.url = url
    }
}
