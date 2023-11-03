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
            Spacer(minLength: 0)
            HStack{
                Image("Chipil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.vertical)
                Text("Chipil")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            HStack{
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Inicio de sesión")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Porfavor inicie para continuar")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                
                Spacer(minLength: 0)
            }
            .padding()
            Group{
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
                .padding(.top)
                
                Button(action: {}, label:{
                    Text("¿olvidaste tu contraseña?")
                        .foregroundColor(Color.white.opacity(0.6))
                })
        }//Vstack principal
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
    }
}

#Preview {
    LoginEmailView(authenticationViewModel: AuthenticationViewModel())
}
