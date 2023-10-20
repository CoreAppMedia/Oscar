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
        VStack{
            Text("Hasta aqui vas bien")
            Button{
                authenticationViewModel.logout()
            }label: {
                Image(systemName: "arrowshape.backward.circle.fill")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .tint(.black)
        }
        .controlSize(.large)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .padding(.top, 40)
        
        }
    }

#Preview {
    ViewPrincipal(authenticationViewModel: AuthenticationViewModel())
}
