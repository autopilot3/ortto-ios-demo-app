//
//  ContentView.swift
//  ortto-ios-demo-app
//
//  Created by Mitchell Flindell on 1/8/2024.
//

import SwiftUI
import OrttoSDKCore

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var userName = ""
    @State private var sessionLogMessage = ""

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            if isLoggedIn {
                Text("Welcome, \(userName)!")
            } else {
                Text("Hello, world!")
            }
            
            Button(action: {
                if isLoggedIn {
                    logout()
                } else {
                    login()
                }
            }) {
                Text(isLoggedIn ? "Logout" : "Login")
            }
            .padding()
            
            Button(action: identifyAgain) {
                Text("Identify Again")
            }
            .padding()
            
            
            
            Button(action: logOrttoSession) {
                Text("Log Ortto Session")
            }
            .padding()
            
            if !sessionLogMessage.isEmpty {
                Text(sessionLogMessage)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .padding()
    }
    
    private func login() {
        // Simulate login with a random name
        isLoggedIn = true
        let uuid = UUID().uuidString
        
        let userName = ["Chris", "Joe", "Den", "Pete", "Eva", "Kate", "Donald", "John", "Zoe", "Pinnochio", "Erica", "Jacquie"].randomElement() ?? "User"

        // Identify user with Ortto
        let user = UserIdentifier(
            contactID: nil,
            email: "\(userName.lowercased())+\(uuid)@example.com",
            phone: nil,
            externalID: uuid,
            firstName: userName,
            lastName: "User"
        )
        
        Ortto.shared.identify(user) { result in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }
    
    private func logout() {
        isLoggedIn = false
        userName = ""
        Ortto.shared.clearIdentity { response in
            print("Cleared Identity")
        }
        // You might want to clear the Ortto identification here if applicable
    }
    
    private func logOrttoSession() {
        if let sessionData = Ortto.shared.userStorage.session {
            sessionLogMessage = "Ortto Session: \(sessionData)"
            print("Ortto Session: \(sessionData)")
        } else {
            sessionLogMessage = "No Ortto session data available"
            print("No Ortto session data available")
        }
        
        let user = Ortto.shared.userStorage.user
        
        print("user \(user?.firstName)")
        Ortto.shared.dispatchPushRequest()
    }
}

#Preview {
    ContentView()
}
