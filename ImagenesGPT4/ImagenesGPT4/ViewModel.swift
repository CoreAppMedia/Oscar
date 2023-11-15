//
//  ViewModel.swift
//  ImagenesGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//

import Foundation
final class ViewModel: ObservableObject{
    private let urlSession: URLSession
    @Published var imageURL: URL?
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func generateImage(withText text: String) async{
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        
        let dictionary: [String: Any] = [
        
                "model": "dall-e-3",
                "prompt": text,
                "n": 1,
                "size": "1024x1024"
        ]
        
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        do{
            
            let(data, _ ) = try await urlSession.data(for: urlRequest)
            let model = try JSONDecoder().decode(ModelResponse.self, from: data)
            
            DispatchQueue.main.async{
                guard let firsModel = model.data.first else{
                    return
                }
                self.imageURL = URL(string: firsModel.url)
                print(self.imageURL ?? "no hay imagenURL")
                        
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
