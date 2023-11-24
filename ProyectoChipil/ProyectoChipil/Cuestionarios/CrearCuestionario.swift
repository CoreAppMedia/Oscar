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
import Firebase
import FirebaseFirestoreSwift


struct Imprimir: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @Binding var value: String
    @State private var DatosPerfil: Informacion?
    @State private var questions: [Preguntas] = []
    var body: some View {
       Text("Hola")
       
    }
    
    //funciones para obtener la informasion del cuestionatio y las Preguntas
    func fetchData(usuario: String)async throws{
        print("hasta aqui vamos bien")
        let preguntas = try await Firestore.firestore().collection("Cuestionarios").document("Informacion").collection("Questions").getDocuments().documents.compactMap{
            try $0.data(as: Preguntas.self)
        }

        //actualizar la infromacion en el hilo principal
        await MainActor.run(body: {
            self.questions = preguntas
        })
    }//fin de la funcion
    
}

#Preview {
    PerfilUsuario(authenticationViewModel: AuthenticationViewModel(), value:.constant(""))
}




