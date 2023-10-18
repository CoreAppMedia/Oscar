//
//  CrearPerfil.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI

struct CrearPerfil: View {
    @ObservedObject var LinkViewModel: LinkViewModel
    @Environment(\.dismiss) private var dismiss
    
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
                }
            }
            .navigationBarTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Guardar") {

                        LinkViewModel.createNewUser(nombre: nombre, apellidoP: apellidoP, apellidoM: apellidoM, descripcion: descripcion, titulo: titulo, numeroTel: numeroTel,fecha: fecha)
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    CrearPerfil(LinkViewModel: LinkViewModel())
}
