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
    
    GMSServices.provideAPIKey("AIzaSyDqu4UryKCeAy19CVaDIXI8LiD2thX1M0U")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
