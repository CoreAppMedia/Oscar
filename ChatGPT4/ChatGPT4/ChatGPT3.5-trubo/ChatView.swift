//
//  chatView.swift
//  ChatGPT4
//
//  Created by mac20@ioslabacatlan.appleid.com on 15/11/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id){ message in
                    
                    messageView(message: message)
                    
                }
            }
            HStack{
                TextField("Escribe tu mensaje......",text: $viewModel.currentInput)
                Button{
                    viewModel.sendMessage()
                }label: {
                    Text("Enviar")
                }
            }
        }//Fin Vstack
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack{
            if message.role == .user {Spacer()}
            Text(message.content)
            if message.role == .assistant {Spacer()}
        }
    }
}

#Preview {
    ChatView()
}
