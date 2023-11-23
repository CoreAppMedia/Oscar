//
//  CrearCuestionario.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 23/10/23.
//

//
//  PasswordResetView.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 22/11/23.
//

import SwiftUI

struct PasswordResetView1: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var emailAddress: String = ""
    @State private var verificationCode: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    // Función para generar un código aleatorio
    func generateVerificationCode() -> String {
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map { _ in allowedCharacters.randomElement()! })
    }
    

    var body: some View {
        VStack {
            Text("Recuperar Contraseña")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            TextField("Correo Electrónico", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                TextField("Código de Verificación", text: $verificationCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                    Button{
                        verificationCode = generateVerificationCode()
                    }label: {
                        Image(systemName: "gobackward")
                    }
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
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        
        .padding()
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
    PasswordResetView1(authenticationViewModel: AuthenticationViewModel())
}
