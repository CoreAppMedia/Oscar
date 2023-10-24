//
//  ProyectoChipilApp.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
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
struct ProyectoChipilApp: App {
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    

    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user{
                BaseView(authenticationViewModel: authenticationViewModel).preferredColorScheme(.light)
            }else{
                ContentView(authenticationViewModel: authenticationViewModel).preferredColorScheme(.light)
            }
        }
    }
}
