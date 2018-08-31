import Foundation

struct Artist: BaseMediaObject {

    enum CodingKeys : String, CodingKey {
        case name
        case mbid
        case playcount
        case listeners
        case images = "image"
    }
    
    var name, mbid: String
    var playcount, listeners: String?
    var images: [Image]?
}
