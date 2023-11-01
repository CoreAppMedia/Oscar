//
//  ContentView.swift
//  Login
//
//  Created by mac20@ioslabacatlan.appleid.com on 01/11/23.
//

import SwiftUI
import LocalAuthentication
struct ContentView: View {
    @AppStorage("status") var logged = false
    
    var body: some View {
        NavigationView{
            if logged{
                HomePrueba()
                    .navigationTitle("Home Master")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            }else{
                Login()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
