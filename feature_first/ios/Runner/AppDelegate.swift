import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    /// UISceneライフサイクル移行後は`didFinishLaunchingWithOptions`で`window.rootViewController`が
    /// 未設定のため、プラグインやアプリ独自のチャネル登録はここで行う
    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
        ScreenReaderPlugin.configure(engineBridge.applicationRegistrar.messenger())
    }
}
