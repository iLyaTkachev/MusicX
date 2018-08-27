import Foundation

struct Artist: BaseMediaObject {
    
    let name, mbid: String
    
    init(name: String, mbid: String) {
        self.name = name
        self.mbid = mbid
    }
}
