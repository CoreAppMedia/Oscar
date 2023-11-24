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
    @Binding var value: String
    var body: some View {
        if let perfilData = perfil_1{
            ZStack(){
                ZStack(alignment:.leading){
                    Rectangle()
                        .fill(.white)
                    VStack(spacing: 10 ){
                        Text("Nombre:")
                            .padding(.bottom, -15)
                        Text(perfilData.nombre)
                            .font(.title)
                        Text("Apellidos:")
                            .padding(.bottom, -10)
                        HStack{
                            Text(perfilData.apellidoP)
                                .font(.headline)
                            Text(perfilData.apellidoP)
                                .font(.headline)
                        }
                        Text("Correo electronico:")
                            .padding(.bottom, -15)
                        Text(perfilData.correoElectronico)
                            .font(.title3 .bold())
                        Text("Contacto:")
                            .padding(.bottom, -10)
                        Text(perfilData.numeroTel)
                            .font(.title3 .bold())
                        Text("Carrera:")
                            .padding(.bottom, -10)
                        Text(perfilData.titulo)
                            .font(.title3 .bold())
                        Text("descripcion:")
                            .padding(.bottom, -10)
                        Text(perfilData.descripcion)
                            .font(.title3 .bold())
                       Spacer()
                    }
                    .padding(.top,35)
                    .padding(.leading, 20)

                }
                .cornerRadius(50.0)
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .padding(.top, 70)
                .padding(.bottom,70)
                Image("cara")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .offset(y: -330)
                Image("expediente")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .offset(x: 130, y: 290)
            }
            .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
            
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
