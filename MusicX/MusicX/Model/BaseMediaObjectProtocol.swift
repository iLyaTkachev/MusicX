import Foundation

protocol BaseMediaObject {
    init?(with dictionary: [String:Any])
    static var type: MediaType { get }
}
