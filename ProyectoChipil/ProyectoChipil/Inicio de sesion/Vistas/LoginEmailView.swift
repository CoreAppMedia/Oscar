//
//  LoginEmailView.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPasseord: String = ""
    var body: some View {
        VStack{
            DismissView()
                .padding(.top, 8)
            Group{
                Text("Bienvenido nuevamente a")
                Text("Chipil tu asistente emocional")
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
                HStack{
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Email", text: $textFieldEmail)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(textFieldEmail == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack{
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Password", text: $textFieldPasseord)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(textFieldPasseord == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                Button("Login") {
                    authenticationViewModel.login(email: textFieldEmail, password: textFieldPasseord)
                }
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 150)
                .background(Color.green)
                .clipShape(Capsule())
                .opacity(textFieldEmail != "" && textFieldPasseord != "" ? 1 : 0.5)
                .disabled(textFieldEmail != "" && textFieldPasseord != "" ? false : true)
                
                if let mesengeError = authenticationViewModel.messageError{
                    Text(mesengeError)
                        .bold()
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }
            Spacer()
        }//Vsrak principal
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
    }
}

#Preview {
    LoginEmailView(authenticationViewModel: AuthenticationViewModel())
}
