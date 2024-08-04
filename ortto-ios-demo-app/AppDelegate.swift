//
//  AppDelegate.swift
//  ortto-ios-demo-app
//
//  Created by Mitchell Flindell on 1/8/2024.
//

import Foundation
import SwiftUI
import OrttoSDKCore
import OrttoPushMessagingAPNS

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Load ENV variables
        if let orttoKey = ProcessInfo.processInfo.environment["ORTTO_APPLICATION_KEY"],
           let apiEndpoint = ProcessInfo.processInfo.environment["ORTTO_API_ENDPOINT"] {
            
                // Initialize Ortto
                Ortto.initialize(appKey: orttoKey, endpoint: apiEndpoint) { configuration in
                    // Setup is completed
                }
        } else {
            fatalError("Missing required Ortto ENV keys")
        }
        
        return true
    }
    
    // Add any other app delegate methods you need
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("didRegisterForRemoteNotificationsWithDeviceToken")

        // Handle push notification registration
        PushMessaging.shared.registerDeviceToken(apnsToken: deviceToken)
    }
}
