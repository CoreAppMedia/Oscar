//
//  ChatMessage.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 28/11/23.
//

import SwiftUI

struct ChatBotView: View {
    @State private var newMessage = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(id: UUID(), message: "¡Hola! Soy Chipil tu COmpañero¡¡¡", isUser: false)
    ]

    var body: some View {
        VStack {
            
            List(messages) { message in
                Text(message.message)
                    .padding(8)
                    .background(message.isUser ? Color.blue : Color("chipil"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(4)
                    .multilineTextAlignment(message.isUser ? .trailing : .leading)
            }
            .padding(.vertical)

            HStack {
                TextField("Escribe un mensaje...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: sendMessage) {
                    Text("Enviar")
                        .foregroundColor(.white)
                }
                
                .padding(.trailing)
            }
            .padding()
        }
        
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }

        messages.append(ChatMessage(id: UUID(), message: newMessage, isUser: true))
        let responseMessage = generateChatbotResponse(for: newMessage)
        messages.append(ChatMessage(id: UUID(), message: responseMessage, isUser: false))
        newMessage = ""
    }

    func generateChatbotResponse(for message: String) -> String {
        // Simulando la respuesta del chatbot después de un breve retraso
        // Aquí podrías realizar una llamada a una API o la lógica real del chatbot.
        let response: String

        switch message.lowercased() {
        case "hola":
            response = "¡Hola! ¿Cómo estás?"
        case "adiós":
            response = "¡Hasta luego!"
        case "estoy triste":
            response = "Cuentame, que pasa?"
        default:
            response = "No entendí. ¿Podrías ser más específico?"
        }

        return response
    }
}

struct ChatMessage: Identifiable {
    let id: UUID
    let message: String
    let isUser: Bool
}

