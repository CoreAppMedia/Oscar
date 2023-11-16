//
//  ViewModel.swift
//  ChatGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//

import Foundation
import SwiftOpenAI

final class ViewModel {
    var openAI = SwiftOpenAI(apiKey: "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")
    func send() async {
        //creamos una red de mensajes
        let messages: [MessageChatGPT] = [
            MessageChatGPT(text: "Eres un asistente que responde preguntas de IOS", role: .system),
            MessageChatGPT(text: "¿Cuando se lanzo el primer iphone?", role: .user)
        ]
        //son los parametros para realizar nuestra peticion http://
        let optionalParameters = ChatCompletionsOptionalParameters(temperature: 0.7, stream: true, maxTokens: 50)
        
        do {
            //aqui instanciamos como queremos que con conteste ChatGPT, en este caso con mensajes
            let stream = try await openAI.createChatCompletionsStream(model: .gpt4(.base), messages: messages, optionalParameters: optionalParameters)
            
            for try await response in stream {
                print(response)
            }
        } catch {
            print("Error master: \(error)")
        }
    }
}
