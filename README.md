# tbib_secure_screen

this package for make screenshot or screen recorder with blank screen after save.


## Getting Started

- Android configuration not need do any thing

- Ios configuration go to AppDelegate.swift

```swift
import UIKit
import Flutter
import tbib_secure_screen


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
       TbibSecureScreenPlugin.register(with: self.registrar(forPlugin: "tbib_secure_screen")!)
   TbibSecureScreenPlugin.shared?.initSecure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    override func applicationWillResignActive(
    _ application: UIApplication
  ) {
     TbibSecureScreenPlugin.shared?.blurScreen()
  }
  override func applicationDidBecomeActive(
    _ application: UIApplication
  ) {
     TbibSecureScreenPlugin.shared?.removeBlurScreen()
  }
}

```

# Note

In iOS the screen will be blank anywhere in the app and not in a specific screen, this means it will be activated automatically.

Android work in specific screen

## You need call this to active plugin in flutter (Android)

```dart
  TBIBSecureScreen().setSecureScreen();
```

## You need call this to un active plugin in flutter (Android)

```dart
   TBIBSecureScreen().setUnsecureScreen
```