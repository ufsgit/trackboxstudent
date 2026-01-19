import UIKit
//import FirebaseCore
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
       // Add the code to prevent screenshots
        if let window = self.window {
            window.isHidden = true
        }
//      FirebaseApp.configure();
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
