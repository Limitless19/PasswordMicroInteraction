import Flutter
import UIKit

public class SwiftPasswordmicrointeractionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "passwordmicrointeraction", binaryMessenger: registrar.messenger())
    let instance = SwiftPasswordmicrointeractionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
