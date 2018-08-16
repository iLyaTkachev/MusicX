import Foundation
import UIKit

final class Utils {
    
    static func dataToJson(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    static func getHashFromImageUrl(url: String) -> String {
        return String(url.suffix(36).prefix(32))
    }
    
    static func getViewController(storyboardName: String, vcId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: vcId)
    }
    
    static func currentQueueName() -> String? {
        let name = __dispatch_queue_get_label(nil)
        
        return String(cString: name, encoding: .utf8)
    }
}
