//
//  OpenAIservice.swift
//  ChatGPT4
//
//  Created by mac20@ioslabacatlan.appleid.com on 15/11/23.
//

import Foundation
import Alamofire

class OpenAIservice{
    private let endpointUrl = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChaResponse? {
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAiKey)"
            
        ]
        return try? await AF.request(endpointUrl, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChaResponse.self).value
    }
}

struct OpenAIChatBody: Encodable{
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable{
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable{
    case system
    case user
    case assistant
}

struct OpenAIChaResponse: Decodable{
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable{
    let message: OpenAIChatMessage
}
