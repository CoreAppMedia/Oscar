//
//  ViewPrincipal.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI
import LocalAuthentication
struct ViewPrincipal: View {
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
    ViewPrincipal()
}

