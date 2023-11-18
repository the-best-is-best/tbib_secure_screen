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
        do{
        if (self.activeSecureScreen==true) {
            
            guard let window = UIApplication.shared.windows.first else {
                return
            }
            window.rootViewController?.view.endEditing(true)
            window.isHidden = true
        }
       }catch {}
    }

    public func removeBlurScreen() {
      do{
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        window.isHidden = false;
      }catch {}
    }
    public func initSecure(){
        do{
         
         guard let window = UIApplication.shared.windows.first else {
            return
        }
        let field = UITextField()
        field.isSecureTextEntry = true
        field.isHidden = true // Initially hide the field
        window.addSubview(field)
        self.secureTextField = field
        }
        catch {}
    } 
}
