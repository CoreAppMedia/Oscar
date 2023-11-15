//
//  ChatView.swift
//  ImagenesGPT4
//
//  Created by Oscar Valdes on 15/11/23.
import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSentByUser: Bool
}

struct ChatView: View {
    @State private var messages: [Message] = []
    @State private var newMessageText = ""

    var body: some View {
        VStack {
            List(messages) { message in
                MessageBubble(message: message)
            }
            .onAppear {
                // Cargar mensajes previos, si los hubiera
            }

            HStack {
                TextField("Escribe un mensaje...", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: sendMessage) {
                    Text("Enviar")
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }

    func sendMessage() {
        guard !newMessageText.isEmpty else { return }

        let userMessage = Message(text: newMessageText, isSentByUser: true)
        messages.append(userMessage)

        // Llama a la función para generar una respuesta de OpenAI
        generateResponse(to: newMessageText)

        newMessageText = ""
    }

    func generateResponse(to message: String) {
        let apiKey = "TU_API_KEY_AQUI"
        let urlString = "https://api.openai.com/v1/chat/completions"

        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                [
                    "role": "user",
                    "content": message
                ]
            ]
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error al realizar la solicitud: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No se recibieron datos")
                    return
                }

                do {
                    let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                    let aiResponse = response.choices.first?.message?.first?.content ?? "No se encontró respuesta"
                    
                    let aiMessage = Message(text: aiResponse, isSentByUser: false)
                    messages.append(aiMessage)
                } catch {
                    print("Error al procesar los datos recibidos:", error.localizedDescription)
                }
            }

            task.resume()
        } catch {
            print("Error al generar los datos de la solicitud:", error.localizedDescription)
        }
    }
}

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isSentByUser {
                Spacer()
                Text(message.text)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.text)
                    .padding(10)
                    .background(Color.gray.opacity(0.5))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                Spacer()
            }
        }
        .padding(5)
    }
}

#Preview {
    ChatView()
}

struct OpenAIResponse: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: [MessageContent]?

        struct MessageContent: Decodable {
            let role: String
            let content: String
        }
    }
}








