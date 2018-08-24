import Foundation
import UIKit

final class Utils {
    
    static func dataToJson(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    static func getHashFromImageUrl(url: String) -> String {
        return String(url.suffix(36).prefix(32))
    }
    
    static func getFileNameFromImageUrl(url: String) -> String {
        return String(url.suffix(40)).replacingOccurrences(of: "/", with: "_")
    }
    
    static func getViewController(storyboardName: String, vcId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: vcId)
    }
    
    static func currentQueueName() -> String? {
        let name = __dispatch_queue_get_label(nil)
        
        return String(cString: name, encoding: .utf8)
    }
    
    static func setConstraints(from parent: UIView, to child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        child.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        child.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        child.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        child.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
    }
    
}
