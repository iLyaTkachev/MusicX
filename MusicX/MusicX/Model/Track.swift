import Foundation

class Track: BaseMediaObject {
    static let type: MediaType = .track
    
    let name, duration, playcount, listeners, imageUrl: String
    let artist: Artist?
    
    init(name: String, duration: String, playcount: String, listeners: String, imageUrl: String, artist: Artist?) {
        self.name = name
        self.duration = duration
        self.playcount = playcount
        self.listeners = listeners
        self.imageUrl = imageUrl
        self.artist = artist
    }
}
