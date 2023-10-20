//
//  IngresoEmailView.swift
//  Chipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//

import SwiftUI

struct IngresoEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPasseord: String = ""
    
    var body: some View {
        VStack{
            DismissView()
                .padding(.top, 8)
            Group{
                Text("Bienvenido nuevamente a")
                Text("Bienvenidos a Chipil")
                    .bold()
                    .underline()
                }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            Group{
                Text("inicia sesion")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                TextField("añade tu correo electrocino",text: $textFieldEmail )
                TextField("añade tu contraseña",text: $textFieldPasseord )
                Button("Login") {
                    authenticationViewModel.login(email: textFieldEmail, password: textFieldPasseord)
                }
                .padding(.top, 18)
                .buttonStyle(.bordered)
                .tint(.blue)
                
                if let mesengeError = authenticationViewModel.messageError{
                    Text(mesengeError)
                        .bold()
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)
            Spacer()
        }//Vsrak principal
    }
}

#Preview {
    IngresoEmailView(authenticationViewModel: AuthenticationViewModel())
}
