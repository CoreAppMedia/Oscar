//
//  PerfilUsuario.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 22/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct PerfilUsuario: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var perfil_1: PerfilData?
    
    @State private var usuarioTexto: String = ""
    var nombreDeUsuario: String {
        return authenticationViewModel.user?.email ?? "Miriam@gmail.com"
    }
    @Binding var value: String
    
    var body: some View {
        if let perfilData = perfil_1{
            VStack(spacing: 10){
                Text("Bienvenido:")
                    Text(perfilData.nombre)
                        .font(.title)
                        .fontWeight(.semibold)
                VStack{
                    Text("Licenciatura a la que pertenece: ")
                    Text(perfilData.descripcion)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack{
                    Text("Campus y Grado: ")
                    Text(perfilData.titulo)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack{
                    Text("Nombre Completo: ")
                    HStack{
                        Text(perfilData.apellidoP)
                        Text(perfilData.apellidoM)
                        Text(perfilData.nombre)
                    }
                    .fontWeight(.semibold)
                }
                VStack{
                    Text("Telefono: ")
                    Text(perfilData.numeroTel)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                VStack{
                    Text("Correo electronico: ")
                    Text(usuarioTexto)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .onAppear {
                // Actualizar la variable usuarioTexto cuando se carga la vista
                usuarioTexto = nombreDeUsuario
            }
            .padding(15)
            
        }else{
            VStack(spacing: 4){
                ProgressView()
                Text("Porfavor espere")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .task {
                do{
                    try await fetchData(usuario: value)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //funciones para obtener la informasion del cuestionatio y las Preguntas
    func fetchData(usuario: String)async throws{
        print("hasta aqui vamos bien")
        print(usuario)
        let perfilData = try await Firestore.firestore().collection("Usuarios").document(usuario).getDocument().data(as: PerfilData.self)

        //actualizar la infromacion en el hilo principal
        await MainActor.run(body: {
            self.perfil_1 = perfilData
        })
        
        
    }//fin de la funcion
}

#Preview {
    PerfilUsuario(authenticationViewModel: AuthenticationViewModel(), value:.constant(""))
}




struct PerfilData: Codable{
    let nombre: String
    let apellidoP: String
    let apellidoM: String
    let descripcion: String
    let titulo: String
    let numeroTel: String
    let correoElectronico: String
    
    
    enum CodingKeys: CodingKey{
        
        case nombre
        case apellidoP
        case apellidoM
        case descripcion
        case titulo
        case numeroTel
        case correoElectronico
        
    }
    
    
}
