//
//  testApp.swift
//  test
//
//  Created by thrxmbxne on 20/12/23.
//

import SwiftUI
import FirebaseCore


@main
struct testApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("FireBase Configured")
    return true
  }
}


