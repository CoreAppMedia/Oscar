//
//  ViewModel.swift
//  ImagenesGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//

import Foundation
import UIKit

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

////////////////


func cargarImagenDesdeURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: urlString) else {
        print("URL inválida")
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error al cargar la imagen:", error.localizedDescription)
            completion(nil)
            return
        }

        guard let data = data else {
            print("No se recibieron datos para la imagen")
            completion(nil)
            return
        }

        let image = UIImage(data: data)
        completion(image)
    }.resume()
}








