import Flutter
// import AVKit
import AVFoundation
import UIKit

public class TbibSecureScreenPlugin: NSObject, FlutterPlugin { 
  
  private var screenCaptureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?


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
    #if !targetEnvironment(simulator)
    let captureDevice = AVCaptureDevice.default(for: .video)
    if let device = captureDevice {
      do {
        let input = try AVCaptureDeviceInput(device: device)
        screenCaptureSession = AVCaptureSession()
        screenCaptureSession?.addInput(input)

        previewLayer = AVCaptureVideoPreviewLayer(session: screenCaptureSession!)
        if let window = UIApplication.shared.windows.first {
          previewLayer?.frame = window.bounds
          window.layer.addSublayer(previewLayer!)
        }

        screenCaptureSession?.startRunning()
      } catch {
        print("Error setting up screen capture prevention: \(error.localizedDescription)")
      }
    }
    #endif
  }

  private func stopScreenCapturePrevention() {
    previewLayer?.removeFromSuperlayer()
    screenCaptureSession?.stopRunning()
    previewLayer = nil
    screenCaptureSession = nil
  }

}

