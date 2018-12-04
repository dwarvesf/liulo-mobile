import UIKit
import Flutter
import Fabric
import Crashlytics
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    Fabric.with([Crashlytics.self])
    
    GMSServices.provideAPIKey("AIzaSyBx7_OdvgvFR7_9mPz-XKo1bWNiOp5v0Q4")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
