//
//  ContentView.swift
//  Chipil_test
//
//  Created by ximena mejia  on 19/09/23.
//



import SwiftUI
import PDFKit
import UIKit

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswer: String
}

struct ContentView: View {
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String?
    @State private var score = 0
    @State private var showAnswers = false
    @State private var userAnswers: [String?] = [] // Almacenar las respuestas del usuario
    @State var PDFUrl: URL?
    @State var showShareSheet: Bool = false
    let questions: [Question] = [
        Question(text: "¿Cuál es la capital de Francia?", options: ["Londres", "Madrid", "París"], correctAnswer: "París"),
        Question(text: "¿Cuál es el río más largo del mundo?", options: ["Nilo", "Amazonas", "Mississippi"], correctAnswer: "Amazonas"),
        Question(text: "¿Cuál es el planeta más grande del sistema solar?", options: ["Tierra", "Marte", "Júpiter"], correctAnswer: "Júpiter")
    ]

    var body: some View {
        VStack {
            if currentQuestionIndex < questions.count {
                Text("Pregunta \(currentQuestionIndex + 1)")
                    .font(.headline)
                    .padding()
                Text(questions[currentQuestionIndex].text)
                    .font(.title)
                
                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                    Button(action: {
                        selectedAnswer = option
                        checkAnswer()
                    }) {
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
               Text("Puntaje: \(score)")
                    .font(.headline)
                
                Button("Siguiente Pregunta") {
                    nextQuestion()
                }
                .disabled(selectedAnswer == nil)
                .padding()
                
            } else if showAnswers { // Mostrar respuestas al final del cuestionario
                VStack {//vstak de las respuestas , esto hay que cinvertir a pdf
                    ScrollView{
                        
                        Button {
                            exportPDF{
                                self
                            } completion: { status, url in
                                if let url = url,status{
                                    self.PDFUrl = url
                                    self.showShareSheet.toggle()
                                } else {
                                    print ("falied to produce ")
                                    }
                                }
                            } label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                        }
                        
                        Text("TU CUESTIONARIO:")
                        
                            .font(.headline)
                            .padding()
                        
                        ForEach(0..<questions.count, id: \.self) { index in
                            Text("\(index + 1). \(questions[index].text)")
                            
                                .font(.title)
                            
                                .padding()
                            Text("Tu respuesta: \(userAnswers[index] ?? "No respondida")")
                                .font(.headline)
                            Text("Respuesta Correcta: \(questions[index].correctAnswer)")
                             .font(.headline)
                             .padding()
                            
                            
                            
                             
                        }
                        
                    }//scroll
                    .sheet(isPresented: $showShareSheet){
                        PDFUrl = nil
                    } content: {
                        if let PDFUrl = PDFUrl {
                            ShareSheet(urls: [PDFUrl])
                        }
                    }//
                }
                
            }
            
        }
        .padding()
    
    }
    
    


    func checkAnswer() {
        userAnswers.append(selectedAnswer) // Almacena la respuesta del usuario
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
    }

    func nextQuestion() {
        
        currentQuestionIndex += 1
        selectedAnswer = nil

        if currentQuestionIndex >= questions.count {
            
            showAnswers = true // Mostrar respuestas al final del cuestionario
        }
    }
}


#Preview {
    ContentView()
}

struct ShareSheet: UIViewControllerRepresentable{
    var urls:[Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
