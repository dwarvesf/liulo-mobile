import UIKit
import Flutter
import Fabric
import Crashlytics

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    Fabric.with([Crashlytics.self])
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
