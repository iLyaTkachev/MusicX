import Foundation

struct Artist: BaseMediaObject, Codable {

    enum CodingKeys : String, CodingKey {
        case name
        case id = "mbid"
        case playcount
        case listeners
        case images = "image"
    }
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    var name, id: String
    var playcount, listeners: String?
    var images: [Image]?
}
