//
//  RegisterEmailView.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPasseord: String = ""
    
    var body: some View {
        VStack{
            DismissView()
                .padding(.top, 8)
            Group{
                Text("Bienvenido a")
                Text("Liga de futbol Zapotitlán")
                    .bold()
                    .underline()
                }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            Group{
                Text("Registrate")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                TextField("añade tu correo electrocino",text: $textFieldEmail )
                TextField("añade tu contraseña",text: $textFieldPasseord )
                Button("Aceptar") {
                    authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPasseord)
                }
                .padding(.top, 18)
                .buttonStyle(.bordered)
                .tint(.blue)
                if let messageError = authenticationViewModel.messageError{
                    Text(messageError)
                        .bold()
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.top,20)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)
            Spacer()
        }//Vsrak principal
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}
