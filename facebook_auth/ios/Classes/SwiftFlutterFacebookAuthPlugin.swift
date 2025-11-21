import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFlutterFacebookAuthPlugin: NSObject, FlutterPlugin {
    let facebookAuth = FacebookAuth()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Updated Facebook SDK initialization
        Settings.shared.isAdvertiserIDCollectionEnabled = true
        Settings.shared.isAdvertiserTrackingEnabled = true
        
        let channel = FlutterMethodChannel(name: "app.meedu/flutter_facebook_auth", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterFacebookAuthPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.facebookAuth.handle(call, result: result)
    }

    /// START ALLOW HANDLE NATIVE FACEBOOK APP
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        var options = [UIApplication.LaunchOptionsKey: Any]()
        for (k, value) in launchOptions {
            let key = k as! UIApplication.LaunchOptionsKey
            options[key] = value
        }
        
        // Updated for newer Facebook SDK
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: options
        )
        return true
    }
    
    public func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        // Updated method call for newer Facebook SDK
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    // Add this method for scene-based lifecycle (iOS 13+)
    @available(iOS 13.0, *)
    public func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Updated for scene-based apps
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
    /// END ALLOW HANDLE NATIVE FACEBOOK APP
}