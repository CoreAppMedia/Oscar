//
//  Home.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 23/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct HomeAnsiedad: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var DatosPerfil: Informacion?
    //variable Pribada que contendra la estructura "Questions"
    @State private var questions: [Preguntas] = []
    
    @State private var usuarioTexto: String = ""
    var nombreDeUsuario: String {
        return authenticationViewModel.user?.email ?? "Miriam@gmail.com"
    }
    @Binding var value: String
    //variable Pribada Para iniciar el cuestionario
    @State private var startQuiz: Bool = false
    
    var body: some View {
        if let info = DatosPerfil{
            VStack(spacing: 10){
                CustomLabel("list.bullet.rectangle.portrait", "\(questions.count)", "Preguntas de opcion multiple")
                    .padding(.top,20)
                
                CustomLabel("person", "\(info.peopleAttended)", "asistencia de personas al ejercicio")
                    .padding(.top,5)
                Divider()
                    .padding(.horizontal, -15)
                    .padding(.top,15)
                if !info.rules.isEmpty{
                    RulesView(info.rules)
                }
                
                CustomButton(title: "Iniciar Test", onClick: {
                    startQuiz.toggle()
                    
                })
                .vAligh(.bottom)
                
            }
            
            .navigationTitle(info.title)
            .padding(15)
            .vAligh(.top)
            .fullScreenCover(isPresented: $startQuiz){
                QuestionsViews(info: info, questions: questions){
                    //el usuario  a completado con exito el cuestionario
                    //se acrtualiza la interfaz de usuario
                    DatosPerfil?.peopleAttended += 1
                }
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
                    try await fetchData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    //estraer de la BD en Firebase las reglas para los cuestionarios y mostrarlas en una View
    @ViewBuilder
    func RulesView(_ Rules: [String])->some View{
        VStack(alignment: .leading, spacing: 15) {
            Text("antes de iniciar lea cuidadosamente")
                .font(.title3)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .padding(.bottom,12)
            ForEach(Rules, id: \.self){ rule in
                HStack(alignment: .top,spacing: 10) {
                    Circle()
                        .fill(.white)
                        .frame(width: 8,height: 8)
                        .offset(y:6)
                    Text(rule)
                        .foregroundColor(Color.white)
                        .lineLimit(3)
                }
            }
        }
        
    }
    
    //Etiqueta personalizada(custom label)
    @ViewBuilder
    func CustomLabel(_ image: String, _ title: String, _ subTitle: String)->some View{
        HStack{
            Image(systemName: image)
                .font(.title3)
                .frame(width: 45,height: 45)
                .background{
                    Circle()
                        .fill(.white)
                        .padding(-1)
                        .background{
                            Circle()
                                .stroke(Color(.black), lineWidth: 2)
                        }
                }
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.white))
                Text(subTitle)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .hAligh(.leading)
        }
    }
    
    //funciones para obtener la informasion del cuestionatio y las Preguntas
    func fetchData()async throws{
        print("hasta aqui vamos bien")
        let info = try await Firestore.firestore().collection("Cuestionario1").document("Ansiedad").getDocument().data(as: Informacion.self)
        let preguntas = try await Firestore.firestore().collection("Cuestionario1").document("Ansiedad").collection("Preguntas1").getDocuments().documents.compactMap{
            try $0.data(as: Preguntas.self)
        }

        //actualizar la infromacion en el hilo principal
        await MainActor.run(body: {
            self.DatosPerfil = info
            self.questions = preguntas
        })
        
        
    }//fin de la funcion
}

#Preview {
    HomeAnsiedad(authenticationViewModel: AuthenticationViewModel(), value: .constant(""))
}



