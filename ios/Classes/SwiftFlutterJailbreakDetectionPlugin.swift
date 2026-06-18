import Flutter
import UIKit
import IOSSecuritySuite

public class SwiftFlutterJailbreakDetectionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_jailbreak_detection", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterJailbreakDetectionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    DispatchQueue.global(qos: .userInitiated).async {
      switch call.method {
      case "jailbroken":
        let isJailbroken = IOSSecuritySuite.amIJailbroken()
        DispatchQueue.main.async {
          result(isJailbroken)
        }
        
      case "developerMode":
        let isEmulator = IOSSecuritySuite.amIRunInEmulator()
        
        DispatchQueue.main.async {
          result(isEmulator)
        }
        
      default:
        DispatchQueue.main.async {
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }
}