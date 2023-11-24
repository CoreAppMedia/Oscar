//
//  PasswordResetView.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 22/11/23.
//

import SwiftUI

struct PasswordResetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var emailAddress: String = ""
    @State private var verificationCode: String = ""
    @State private var AutenticaciontionCode: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // Función para generar un código aleatorio
    func generateVerificationCode() -> String {
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map { _ in allowedCharacters.randomElement()! })
    }
    
    
    var body: some View {
        VStack{
            DismissView()

            
            VStack{
                Image("contrasena")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text("Por favor inicie para continuar")
                    .foregroundColor(Color.white.opacity(0.5))
            }
            Group{
                HStack{
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    TextField("Email", text: $emailAddress)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(emailAddress == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
        
                    TextField("Código", text: $verificationCode)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 142)
                        .padding(.bottom,10)

                HStack{
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Codigo", text: $AutenticaciontionCode)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(AutenticaciontionCode == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                Text("Ingrese el código ")
                    .foregroundColor(Color.white.opacity(0.5))
                    .padding(-20)
                
                        Button{
                            verificationCode = generateVerificationCode()
                        }label: {
                            Image(systemName: "gobackward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        .foregroundColor(.white)
                
                        .padding()
                    Spacer()
                
                
            }
            Button("Restablecer Contraseña") {
                // Aquí validarías el código de verificación antes de iniciar el restablecimiento de la contraseña.
                // Puedes comparar el código ingresado con el generado para verificar.

                // Llamar a la función resetPassword solo si la validación del código es exitosa.
                authenticationViewModel.resetPassword(forEmail: emailAddress) { result in
                    switch result {
                    case .success:
                        alertMessage = "Se ha enviado un correo de restablecimiento a \(emailAddress)"
                    case .failure(let error):
                        alertMessage = "Error al restablecer la contraseña: \(error.localizedDescription)"
                    }
                    showingAlert = true
                }
             //   dismiss()
            }
            .fontWeight(.heavy)
            .foregroundColor(.black)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 150)
            .background(Color.green)
            .clipShape(Capsule())
            .opacity(emailAddress != "" && AutenticaciontionCode != "" ? 1 : 0.5)
            .disabled(emailAddress != "" && AutenticaciontionCode != "" ? false : true)
            
            
        }//Vstack principal
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Recuperación de Contraseña"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            verificationCode = generateVerificationCode()
        }
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
    }
}


#Preview {
    PasswordResetView(authenticationViewModel: AuthenticationViewModel())
}
