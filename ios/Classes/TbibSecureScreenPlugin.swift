import Flutter
// import AVKit
// import AVFoundation
import UIKit

public class TbibSecureScreenPlugin: NSObject, FlutterPlugin { 
  
  static var activeSecureScreen = false;

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
     self.activeSecureScreen = true;
      result("success")
    case "setUnSecureScreen":
     self.activeSecureScreen = false;
      result("success")
    default:
      result(FlutterMethodNotImplemented)
    }
  }
   public func listenToTakeScreenRecording() {
   guard let window = UIApplication.shared.windows.first else {
            return
        }
        if #available(iOS 11.0, *) {
            NotificationCenter.default.addObserver(
              forName: UIScreen.capturedDidChangeNotification,
              object: nil,
              queue: .main) { notification in
          
                  DispatchQueue.main.async {
                      if window?.isHidden == false{
                          self.hideScreen()
                      }
                      
                  }
              }
        } else {
        }
    }
    
    public func listenToTakeScreenshot() {  
       guard let window = UIApplication.shared.windows.first else {
            return
        }
        NotificationCenter.default.addObserver(
          forName: UIApplication.userDidTakeScreenshotNotification,
          object: nil,
          queue: .main) { notification in
              
              if window?.isHidden == false{
                  self.blurScreen();
              }
            }
    }
    
   public func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
      if(activeSecureScreen){
         guard let window = UIApplication.shared.windows.first else {
            return
        }
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen?.addSubview(blurBackground)
        blurBackground.frame = (screen?.frame)!
        window?.addSubview(screen!)
      }
    }

  public  func removeBlurScreen() {

         guard let window = UIApplication.shared.windows.first else {
            return
        }
        screen?.removeFromSuperview()
    }

}

