//
//  RegisterEmailView.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI
import FirebaseFirestore
struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPasseord: String = ""
    
    @State private var nombre = ""
    @State private var apellidoP = ""
    @State private var apellidoM = ""
    @State private var descripcion = ""
    @State private var titulo = ""
    @State private var numeroTel = ""
    @State private var fecha = Date()
    
    
    var body: some View {
        VStack{
            DismissView()
                .padding(.top, 8)
            Group{
                Text("Bienvenido a")
                Text("Firebase Prueba")
                    .bold()
                    .underline()
                }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            
            ScrollView{
                Group{
                    Text("Registrate")
                        .tint(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                    TextField("añade tu correo electrocino",text: $textFieldEmail )
                    TextField("Nombre ", text: $nombre)
                    HStack{
                        TextField("Apellido Paterno", text: $apellidoP)
                        TextField("Apellido materno", text: $apellidoM)
                    }
                    TextField("Telefono", text: $numeroTel)
                        .keyboardType(.numberPad)
                    TextField("Descripcion de tu persona", text: $descripcion)
                        .keyboardType(.emailAddress)
                    TextField("grupo al que pertenece", text: $titulo)
                        .keyboardType(.emailAddress)
                    
                    DatePicker("Birthdate", selection: $fecha, displayedComponents: .date)
                    Divider()
                    TextField("añade tu contraseña",text: $textFieldPasseord )
                    Button("Aceptar") {
                        //con esto hacemos la autenticaion
                        authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPasseord)
                     //   en esta parte en donde se crea la columna para cada usuario y su respectiva informacion
                        Firestore.firestore().collection("Usuarios").document(textFieldEmail).setData([
                            "nombre": nombre ,
                            "apellidoP": apellidoP,
                            "apellidoM": apellidoM,
                            "descripcion": descripcion,
                            "titulo": titulo,
                            "numeroTel": numeroTel]) { error in
                            if let error = error {
                                print("Error al agregar el documento \(textFieldEmail): \(error.localizedDescription)")
                            } else {
                                print("Documento \(textFieldEmail) agregado con éxito")
                            }
                        }
                        
                        
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
                
            }//ScrollView
        }//VStack principal
    }
}

#Preview {
    RegisterEmailView(authenticationViewModel: AuthenticationViewModel())
}
