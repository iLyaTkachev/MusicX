import Foundation

struct Track: BaseMediaObject, Codable {
    
    enum CodingKeys : String, CodingKey {
        case name
        case playcount
        case listeners
        case artist
        case images = "image"
    }
    
    init(name: String, id: String, artist: Artist) {
        self.name = name
        self.artist = artist
    }
    
    var name: String
    var id, playcount, listeners: String?
    var artist: Artist
    var images: [Image]?
}
