import Foundation

struct Track: BaseMediaObject {
    
    enum CodingKeys : String, CodingKey {
        case name
        case playcount
        case listeners
        case artist
        case images = "image"
    }
    
    var name, playcount, listeners: String
    var artist: Artist
    var images: [Image]
}
