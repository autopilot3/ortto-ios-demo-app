//
//  ortto_ios_demo_appApp.swift
//  ortto-ios-demo-app
//
//  Created by Mitchell Flindell on 1/8/2024.
//

import SwiftUI

@main
struct OrttoDemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
