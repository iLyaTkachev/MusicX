import Foundation

class Artist: BaseMediaObject {
    static let type: MediaType = .artist
    
    private enum Keys: String {
        case name, mbid
    }
    
    let name, mbid: String
    
    init(name: String, mbid: String) {
        self.name = name
        self.mbid = mbid
    }
    
    required convenience init?(with dictionary: [String : Any]) {
        if let name = dictionary[Keys.name.rawValue] as? String,
            let mbid = dictionary[Keys.mbid.rawValue] as? String {
            
            self.init(name: name, mbid: mbid)
        } else {
            print("Problem with parsing of artist\n")
            return nil
        }
    }
}
