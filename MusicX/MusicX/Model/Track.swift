import Foundation

class Track: BaseMediaObject {
    static let type: MediaType = .track
    
    private enum Keys: String {
        case name, duration, playcount, listeners, artist, image
        case imageUrl = "#text"
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
    
    required convenience init?(with dictionary: [String : Any]) {
        if let name = dictionary[Keys.name.rawValue] as? String,
            let duration = dictionary[Keys.duration.rawValue] as? String,
            let playcount = dictionary[Keys.playcount.rawValue] as? String,
            let listeners = dictionary[Keys.listeners.rawValue] as? String,
            let imagesArray = dictionary[Keys.image.rawValue] as? [Any],
            let imageDictionary = imagesArray[3] as? [String : Any],
            let imageUrl = imageDictionary[Keys.imageUrl.rawValue] as? String,
            let artistDictionary = dictionary[Keys.artist.rawValue] as? [String : Any],
            let artist = Artist(with: artistDictionary) {
            
            self.init(name: name, duration: duration, playcount: playcount, listeners: listeners, imageUrl: imageUrl, artist: artist)
        } else {
            print("Problem with parsing of track\n")
            return nil
        }
    }
}
