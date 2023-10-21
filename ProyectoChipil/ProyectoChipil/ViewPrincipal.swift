//
//  ViewPrincipal.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI

struct ViewPrincipal: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                BaseView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout"){
                    authenticationViewModel.logout()
                }
            }
        }
    }
}

#Preview {
    ViewPrincipal(authenticationViewModel: AuthenticationViewModel())
}
