import Foundation

struct Artist: BaseMediaObject {
    
    let name, mbid: String
    var playcount, listeners, imageUrl: String?
    
    init(name: String, mbid: String) {
        self.name = name
        self.mbid = mbid
    }
    
    init(name: String, mbid: String, playcount: String, listeners: String, imageUrl: String) {
        self.init(name: name, mbid: mbid)
        self.playcount = playcount
        self.listeners = listeners
        self.imageUrl = imageUrl
    }
}
