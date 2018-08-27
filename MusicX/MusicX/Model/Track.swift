import Foundation

struct Track: BaseMediaObject {
    
    let name, playcount, listeners, imageUrl: String
    let artist: Artist?
    
    init(name: String, playcount: String, listeners: String, imageUrl: String, artist: Artist?) {
        self.name = name
        self.playcount = playcount
        self.listeners = listeners
        self.imageUrl = imageUrl
        self.artist = artist
    }
}
