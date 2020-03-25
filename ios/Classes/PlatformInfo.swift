//
//  PlatformInfo.swift
//  learningflutterplugin
//
//  Created by José Lucas Souza das Chagas on 23/03/20.
//

import Flutter
import UIKit

public class PlatformInfo: NSObject, FlutterPlugin {
    static let channelName = "platform_info"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = PlatformInfo()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
}
