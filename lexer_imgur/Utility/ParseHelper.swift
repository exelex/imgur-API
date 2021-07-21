
import Foundation

// MARK: - HelpersFunctions
func printJSONString(_ json: Any?, _ title: String = "") {
    guard let json = json else { print("\(title) - json is nil"); return }
    print(type(of: json))
    if let dict = json as? [String: Any] { print("\(title)\n", dict.jsonString) }
    else if let dict = json as? [[String: Any]] { print("\(title)\n", dict.toJSONString()) }
    else { print("\(title) - json is unknown") }
}
//
// MARK: Array Dict -> JSON String
extension Collection where Iterator.Element == [String: Any] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        guard let arr = self as? [[String: Any]],
              let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
              let str = String(data: dat, encoding: String.Encoding.utf8)
        else { return "[nil]" }
        return str
    }
}
// MARK: Dict -> JSON String
extension Dictionary {
    var jsonString: String {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
              let str = String(data: theJSONData, encoding: .utf8)//.ascii)
        else { return "[nil]" }
        return str
    }
}

// MARK: - Codable
extension Encodable {
    var values: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
