//
//  GeneratedImageView.swift
//  ImagenesGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//
import SwiftUI
import Foundation

struct GeneratedImageView: View {
    @State private var generatedImage: UIImage?
    
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
    
    func generarImagenConDescripcion() {
        let apiKey = "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"
        let urlString = "https://api.openai.com/v1/images/generations"
        let descripcionPaisaje = "Un paisaje surrealista con montañas flotantes, árboles luminosos y un río de colores brillantes."

        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "model": "dall-e-3",
            "prompt": descripcionPaisaje,
            "n": 1,
            "size": "1024x1024"
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
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let output = json["output"] as? [String: Any],
                           let images = output["images"] as? [String] {
                            if let imageURL = images.first {
                                print("URL de la imagen generada:", imageURL)
                                cargarImagenDesdeURL(urlString: imageURL) { image in
                                    DispatchQueue.main.async {
                                        self.generatedImage = image
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("Error al procesar los datos recibidos:", error.localizedDescription)
                }
            }

            task.resume()
        } catch {
            print("Error al generar los datos de la solicitud:", error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            Button("Generar imagen") {
                generarImagenConDescripcion()
            }
            .padding()
            
            if let image = generatedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()
            } else {
                Text("Presiona el botón para generar una imagen")
            }
        }
    }
}


#Preview {
    GeneratedImageView()
}
