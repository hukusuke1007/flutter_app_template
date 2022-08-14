//
//  ScreenReaderPlugin.swift
//  Runner
//
//  Created by 中川祥平 on 2022/08/14.
//

import UIKit
import Flutter

final class ScreenReaderPlugin {
    private enum MethodChannelType: String {
        case screenReader = "com.example.app/method/screenReader"
        var value: String { return self.rawValue }
        
        enum MethodNameType: String {
            case fetchEnable
            var value: String { return self.rawValue }
        }
    }
    
    private enum EventChannelType: String {
        case screenReader = "com.example.app/event/screenReader/fetchEnable"
        var value: String { return self.rawValue }
    }
    
    static func configure(_ controller: FlutterViewController) {
        /// MethodChannel
        /// https://docs.flutter.dev/development/platform-integration/platform-channels#step-4-add-an-ios-platform-specific-implementation
        let channel = FlutterMethodChannel(
            name: MethodChannelType.screenReader.value,
            binaryMessenger: controller.binaryMessenger
        )
        channel.setMethodCallHandler { (call, result) in
            if (call.method == MethodChannelType.MethodNameType.fetchEnable.value) {
                let value = UIAccessibility.isVoiceOverRunning
                Logger.info("fetchEnable: \(value.description)")
                result(value)
            } else {
                Logger.error("FlutterMethodNotImplemented")
                result(FlutterMethodNotImplemented)
            }
        }
        
        /// EventChannel
        let fetchEnableEventChannel = FlutterEventChannel(
            name: EventChannelType.screenReader.value,
            binaryMessenger: controller.binaryMessenger
        )
        fetchEnableEventChannel.setStreamHandler(FetchEnableStreamHandler())
    }
}

final class FetchEnableStreamHandler: NSObject, FlutterStreamHandler {
    
    private var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeState),
            name: UIAccessibility.voiceOverStatusDidChangeNotification,
            object: nil
        )
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        NotificationCenter.default.removeObserver(self)
        return nil
    }
    
    @objc private func changeState() {
        let value = UIAccessibility.isVoiceOverRunning
        Logger.info("fetchEnable: \(value.description)")
        self.eventSink?(value)
    }
}
