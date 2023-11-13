import Flutter
// import AVKit
// import AVFoundation
import UIKit

public class TbibSecureScreenPlugin: NSObject, FlutterPlugin { 
  
    var blackScreenField: UITextField?


  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "tbib_secure_screen", binaryMessenger: registrar.messenger())
    let instance = TbibSecureScreenPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case  "setSecureScreen":
      startScreenCapturePrevention()
      result("success")
    case "setUnSecureScreen":
    stopScreenCapturePrevention()
      result("success")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
   private func startScreenCapturePrevention() {
      // guard let window = UIApplication.shared.windows.first else {
      //       return
      //   }

      //   blackScreenField = UITextField()
      //   blackScreenField?.isSecureTextEntry = true
      //   window.addSubview(blackScreenField!)
      //   blackScreenField?.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
      //   blackScreenField?.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
      //   window.layer.superlayer?.addSublayer(blackScreenField!.layer)
      //   blackScreenField?.layer.sublayers?.first?.addSublayer(window.layer)

 
  }

  private func stopScreenCapturePrevention() {
    // blackScreenField?.removeFromSuperview()
    //     blackScreenField = nil

  }

}

