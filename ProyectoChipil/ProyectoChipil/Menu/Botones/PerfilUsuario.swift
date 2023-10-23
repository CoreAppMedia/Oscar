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
    @State private var quizInfo: PerfilData?
    
    @State private var usuarioTexto: String = ""
    var nombreDeUsuario: String {
        return authenticationViewModel.user?.email ?? "Miriam@gmail.com"
    }
    @Binding var value: String
    
    var body: some View {
        VStack{
            Text("El valor Actual es: \(value)")
        }
        if let perfilData = quizInfo{
            VStack(spacing: 10){
                Text("El valor Actual es: \(value)")
                Text(usuarioTexto)
                HStack{
                    Text(perfilData.descripcion)
                        .font(.title)
                        .fontWeight(.semibold)

                }
                HStack{
                    Text(perfilData.apellidoP)
                    Text(perfilData.apellidoM)
                    Text(perfilData.nombre)
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
                    try await fetchData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //funciones para obtener la informasion del cuestionatio y las Preguntas
    func fetchData()async throws{
        let perfilData = try await Firestore.firestore().collection("Usuarios").document(value).getDocument().data(as: PerfilData.self)

        //actualizar la infromacion en el hilo principal
        await MainActor.run(body: {
            self.quizInfo = perfilData
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
    
    
    enum CodingKeys: CodingKey{
        
        case nombre
        case apellidoP
        case apellidoM
        case descripcion
        case titulo
        case numeroTel
        
    }
    
    
}
