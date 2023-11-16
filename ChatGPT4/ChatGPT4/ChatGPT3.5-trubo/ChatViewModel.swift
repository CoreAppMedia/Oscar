//
//  ChatViewModel.swift
//  ChatGPT4
//
//  Created by mac20@ioslabacatlan.appleid.com on 15/11/23.
//

import Foundation

extension ChatView{
    class ViewModel: ObservableObject{
        @Published var messages: [Message] = []
        @Published var currentInput: String = ""
        private let openAIService = OpenAIservice()
        
        func sendMessage(){
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, crateAt: Date())
            messages.append(newMessage)
            currentInput = ""
            Task{
                let response = await openAIService.sendMessage(messages: messages)
                
                guard let recevedOpenAIMessage = response?.choices.first?.message else{
                    print("No se recibio el mensaje master")
                    return
                }
                let recevedMessage = Message(id: UUID(), role: recevedOpenAIMessage.role, content: recevedOpenAIMessage.content, crateAt: Date())
                await MainActor.run{
                    messages.append(recevedMessage)
                }
            }
        }
    }
}

struct Message: Decodable{
    let id: UUID
    let role: SenderRole
    let content: String
    let crateAt: Date
    
}
