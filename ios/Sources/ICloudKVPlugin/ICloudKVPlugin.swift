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
      self?.notifyListeners("icloudSync", data: ["reason": reason, "keys": keys])
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
          let value = call.getString("value") else {
      call.reject("Must provide key & value"); return
    }
    store.set(value, forKey: key)
    store.synchronize()
    call.resolve()
  }

  @objc func get(_ call: CAPPluginCall) {
    guard let key = call.getString("key") else {
      call.reject("Must provide key"); return
    }
    call.resolve(["value": store.string(forKey: key) as Any])
  }

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        self.notifyListeners("echo", data: ["value": value])
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
}
