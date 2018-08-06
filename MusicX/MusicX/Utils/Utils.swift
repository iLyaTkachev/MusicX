import Foundation
import UIKit

final class Utils {
    
    static func dataToJson(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    static func getHashFromImageUrl(url: String) -> String {
        return String(url.suffix(36).prefix(32))
    }
    
    static func getViewController(from storyboardName: String, with vcId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: vcId)
    }
}
