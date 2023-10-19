//
//  CrearPerfil.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI
import FirebaseFirestore

struct CrearPerfil: View {
    @ObservedObject var LinkViewModel: LinkViewModel
    @Environment(\.dismiss) private var dismiss
    
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
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Correo Electronico ", text: $textFieldEmail)
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
                    HStack{
                        Text("Contraseña: ")
                        TextField("Contraseña", text: $textFieldPasseord)
                    }
                }
            }
            .navigationBarTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Guardar") {
                        authenticationViewModel.login(email: textFieldEmail, password: textFieldPasseord)
                        LinkViewModel.createNewUser(nombre: nombre, 
                                                    apellidoP: apellidoP,
                                                    apellidoM: apellidoM,
                                                    descripcion: descripcion,
                                                    titulo: titulo,
                                                    numeroTel: numeroTel,
                                                    fecha: fecha)
                        
                        Firestore.firestore().collection("Usuarios").document(textFieldEmail).setData([
                            "nombre": nombre ,
                            "apellidoP": apellidoP,
                            "apellidoM": apellidoM,
                            "descripcion": descripcion,
                            "titulo": titulo,
                            "numeroTel": numeroTel]) { error in
                            if let error = error {
                                print("Error al agregar el documento 'Info': \(error.localizedDescription)")
                            } else {
                                print("Documento 'Info' agregado con éxito a la colección \(textFieldEmail)")
                            }
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    CrearPerfil(LinkViewModel: LinkViewModel(), authenticationViewModel: AuthenticationViewModel())
}
