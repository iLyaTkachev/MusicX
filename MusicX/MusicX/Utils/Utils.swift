import Foundation
import UIKit

final class Utils {
    
    static func dataToJson(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    static func getHashFromImageUrl(url: String) -> String {
        return String(url.suffix(36).prefix(32))
    }
    
    func getViewController<T: UIViewController>(from storyboardName: String, with vcId: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: vcId) as? T else {
            return nil
        }
    }
}
