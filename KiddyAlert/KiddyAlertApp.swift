//
//  KiddyAlertApp.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//

import SwiftUI
import UserNotifications
import Firebase

@main


struct KiddyAlertApp: App {
    @StateObject var viewModel = AuthViewModel()
    
   
    
    init() {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
    }    
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
            
                .onAppear {
                    UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: nil)
                }
            
        }
        .environmentObject(viewModel)
        .modelContainer(for: KidDetail.self)
    }
}


