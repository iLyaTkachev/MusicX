import Foundation

struct Track: BaseMediaObject {
    
    enum CodingKeys : String, CodingKey {
        case name
        case playcount
        case listeners
        case artist
        case images = "image"
    }
    
    init(name: String) {
        self.name = name
    }
    
    var name: String
    var playcount, listeners: String?
    var artist: Artist?
    var images: [Image]?
}
