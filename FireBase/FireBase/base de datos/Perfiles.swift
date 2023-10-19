//
//  Perfiles.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Perfiles: View {
    //variable Pribada que contendra la estructura "Info"
    @State private var quizInfo: PerfilData?
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        if let perfilData = quizInfo{
            VStack(spacing: 10){
                HStack{
                    Text(perfilData.descripcion)
                        .font(.title)
                        .fontWeight(.semibold)
                    Button{
                        authenticationViewModel.logout()
                    }label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                HStack{
                    Text(perfilData.apellidoP)
                    Text(perfilData.apellidoM)
                    Text(perfilData.nombre)
                }
                Spacer()
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
        let perfilData = try await Firestore.firestore().collection("Usuarios").document("Israel@gmail.com").getDocument().data(as: PerfilData.self)

        //actualizar la infromacion en el hilo principal
        await MainActor.run(body: {
            self.quizInfo = perfilData
        })
        
        
    }
}



#Preview {
    Perfiles(authenticationViewModel: AuthenticationViewModel())
}

