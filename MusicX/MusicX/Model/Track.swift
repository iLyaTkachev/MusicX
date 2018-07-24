import Foundation

protocol ModelFromDictionary {
    init?(with trackDictionary: [String:Any])
}

class Track: ModelFromDictionary {
    
    private enum Keys: String {
        case name, duration, playcount, listeners, artist
    }
    
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
    
    required convenience init?(with trackDictionary: [String : Any]) {
        if let name = trackDictionary[Keys.name.rawValue] as? String,
            let duration = trackDictionary["duration"] as? String,
            let playcount = trackDictionary["playcount"] as? String,
            let listeners = trackDictionary["listeners"] as? String
            //let imageUrl = trackDictionary["imageUrl"] as? String,
            //let artist = trackDictionary["artist"] as? Artist {
            {
            self.init(name: name, duration: duration, playcount: playcount, listeners: listeners, imageUrl: "123", artist: nil)
        } else {
            print("Problem parsing track\n")
            return nil
        }
    }
}
