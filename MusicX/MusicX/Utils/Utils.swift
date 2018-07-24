import Foundation

final class Utils {
    
    static func dataToJson(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    static func getHashFromImageUrl(url: String) -> String {
        return String(url.suffix(36).prefix(32))
    }
}
