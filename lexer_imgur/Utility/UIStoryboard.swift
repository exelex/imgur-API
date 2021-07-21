
import UIKit

extension UIStoryboard {
    class func controller<T: UIViewController>(_ storyboard: StoryboardEnum = StoryboardEnum.main) -> T {
        let identifier = T.className
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
    }
    class func initial<T: UIViewController>(_ storyboard: StoryboardEnum) -> T {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateInitialViewController() as! T
    }
    class func nc(_ identifier: String, _ storyboard: StoryboardEnum = StoryboardEnum.main) -> UINavigationController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! UINavigationController
    }
    
    enum StoryboardEnum: String {
        case main = "Main"
        case auth = "Auth"
    }
}

// MARK: - NSObject
extension NSObject {
    class var className: String { return String(describing: self.self) }
}
