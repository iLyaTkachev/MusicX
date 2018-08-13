import Foundation

protocol BaseMediaObject {
    static var type: MediaType { get }
    init?(with dictionary: [String:Any])
}
