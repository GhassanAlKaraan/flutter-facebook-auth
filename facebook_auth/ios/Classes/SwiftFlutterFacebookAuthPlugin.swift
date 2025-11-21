import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFlutterFacebookAuthPlugin: NSObject, FlutterPlugin {
    let facebookAuth = FacebookAuth()

    public static func register(with registrar: FlutterPluginRegistrar) {
        ApplicationDelegate.initialize()
        let channel = FlutterMethodChannel(
            name: "app.meedu/flutter_facebook_auth",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftFlutterFacebookAuthPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.facebookAuth.handle(call, result: result)
    }

    // For FBSDKCoreKit 15+, continue user activity
    @objc(application:continueUserActivity:restorationHandler:)
    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        // FBSDK no longer uses restorationHandler parameter
        return ApplicationDelegate.shared.application(application, continue: userActivity)
    }

    // For FBSDKCoreKit 15+, open URL
    @objc(application:openURL:options:)
    public func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        // FBSDK 15+ only expects app and url
        return ApplicationDelegate.shared.application(app, open: url)
    }
}
