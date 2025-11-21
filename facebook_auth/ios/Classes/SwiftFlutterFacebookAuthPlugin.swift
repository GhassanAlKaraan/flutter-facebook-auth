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

    @objc(application:continueUserActivity:restorationHandler:)
    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return ApplicationDelegate.shared.application(application, continue: userActivity)
    }

    @objc(application:openURL:options:)
    public func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url)
    }
}
