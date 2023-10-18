//
//  ViewPrincipal.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI

struct ViewPrincipal: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        HStack{
            Text("Hola Master")
                .font(.title)
                .fontWeight(.semibold)
            Button{
                authenticationViewModel.logout()
            }label: {
                Image(systemName: "arrowshape.backward.circle.fill")
                    .font(.title)
                    .foregroundColor(.black)
                    
            }
        }
    }
}

#Preview {
    ViewPrincipal(authenticationViewModel: AuthenticationViewModel())
}
