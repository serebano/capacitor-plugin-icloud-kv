import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ICloudKVPlugin)
public class ICloudKVPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "ICloudKVPlugin"
    public let jsName = "ICloudKV"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "set", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "get", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "remove", returnType: CAPPluginReturnPromise),
        // CAPPluginMethod(name: "addListener", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = ICloudKV()

    private let store = NSUbiquitousKeyValueStore.default
    private var observer: NSObjectProtocol?

    override public func load() {
        observer = NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: store,
            queue: .main
        ) { [weak self] note in
            guard let info = note.userInfo,
                  let reason = info[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int,
                  let keys = info[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] else { return }
            self?.notifyListeners("icloudKVDidChange", data: ["reason": reason, "keys": keys])
        }
        store.synchronize()
    }

    deinit {
        if let o = observer {
            NotificationCenter.default.removeObserver(o)
        }
    }

    @objc func set(_ call: CAPPluginCall) {
        guard let key = call.getString("key"),
              let value = call.options["value"] else {
            call.reject("Must provide key & value")
            return
        }
        
        // Convert JavaScript value to appropriate native type
        let nativeValue = convertToNativeValue(value)
        store.set(nativeValue, forKey: key)
        store.synchronize()
        call.resolve()
    }

    @objc func get(_ call: CAPPluginCall) {
        guard let key = call.getString("key") else {
            call.reject("Must provide key")
            return
        }
        
        let value = store.object(forKey: key)
        let jsValue = convertToJSValue(value)
        call.resolve(["value": jsValue])
    }

    @objc func remove(_ call: CAPPluginCall) {
        guard let key = call.getString("key") else {
            call.reject("Must provide key")
            return
        }
        
        store.removeObject(forKey: key)
        store.synchronize()
        call.resolve()
    }

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        self.notifyListeners("echo", data: ["value": value])
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    // MARK: - Helper Methods
    
    private func convertToNativeValue(_ jsValue: Any) -> Any {
        if let stringValue = jsValue as? String {
            return stringValue
        } else if let numberValue = jsValue as? NSNumber {
            return numberValue
        } else if let boolValue = jsValue as? Bool {
            return NSNumber(value: boolValue)
        } else if let dateValue = jsValue as? String {
            // Try to parse as ISO date string
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: dateValue) {
                return date
            }
            // Fallback to string if not a valid date
            return dateValue
        } else if let arrayValue = jsValue as? [Any] {
            return arrayValue.map { convertToNativeValue($0) }
        } else if let dictValue = jsValue as? [String: Any] {
            var nativeDict: [String: Any] = [:]
            for (key, value) in dictValue {
                nativeDict[key] = convertToNativeValue(value)
            }
            return nativeDict
        }
        
        // Default fallback to string
        return String(describing: jsValue)
    }
    
    private func convertToJSValue(_ nativeValue: Any?) -> Any? {
        guard let value = nativeValue else { return nil }
        
        if let stringValue = value as? String {
            return stringValue
        } else if let numberValue = value as? NSNumber {
            // Check if it's a boolean
            if CFGetTypeID(numberValue) == CFBooleanGetTypeID() {
                return numberValue.boolValue
            }
            // Check if it's an integer
            if CFNumberIsFloatType(numberValue) {
                return numberValue.doubleValue
            } else {
                return numberValue.intValue
            }
        } else if let dateValue = value as? Date {
            let formatter = ISO8601DateFormatter()
            return formatter.string(from: dateValue)
        } else if let arrayValue = value as? [Any] {
            return arrayValue.map { convertToJSValue($0) }
        } else if let dictValue = value as? [String: Any] {
            var jsDict: [String: Any] = [:]
            for (key, value) in dictValue {
                jsDict[key] = convertToJSValue(value)
            }
            return jsDict
        }
        
        // Default fallback to string
        return String(describing: value)
    }
}
