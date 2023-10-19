//
//  FireBaseApp.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FireBaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user{
                ViewPrincipal(authenticationViewModel: authenticationViewModel)
            }else{
                ContentView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
