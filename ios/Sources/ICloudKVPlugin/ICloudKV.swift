import Foundation

@objc public class ICloudKV: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
