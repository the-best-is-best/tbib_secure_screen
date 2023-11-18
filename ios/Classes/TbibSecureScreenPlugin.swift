import Flutter
import UIKit

public class TbibSecureScreenPlugin: NSObject, FlutterPlugin {
    
    var activeSecureScreen = false
    // var secureTextField: UITextField?

    public static var shared: TbibSecureScreenPlugin?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tbib_secure_screen", binaryMessenger: registrar.messenger())
        shared = TbibSecureScreenPlugin()
       
        registrar.addMethodCallDelegate(shared!, channel: channel)
    }  

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "setSecureScreen":
            self.activeSecureScreen = true
            // self.blurScreen()
            result("success")
        case "setUnSecureScreen":
             self.activeSecureScreen = false
            // self.removeBlurScreen()
            result("success")
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func blurScreen() {
        if activeSecureScreen {
            
            guard let window = UIApplication.shared.windows.first else {
                return
            }
            window.rootViewController?.view.endEditing(true)
            window.isHidden = true
       }
    }

    public func removeBlurScreen() {
        // secureTextField?.removeFromSuperview()
        // secureTextField = nil
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        window.isHidden = false
    }
    public func initSecure(){
         guard let window = UIApplication.shared.windows.first else {
                return
        }
        let field = UITextField()
        field.isSecureTextEntry = true
        window.addSubview(field)
        field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        window.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.first?.addSublayer(window.layer)
    } 
}
