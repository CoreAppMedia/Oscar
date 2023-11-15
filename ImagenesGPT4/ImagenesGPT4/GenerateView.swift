//
//  GenerateView.swift
//  ImagenesGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//

import SwiftUI

struct GenerateView: View {
    @StateObject var viewModel = ViewModel()
    @State var text = "Dos astronautas llegando a la luna en una nave espacial"
    var body: some View {
        VStack{
            Text("Hola Master")
            Form {
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    
                    VStack{
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                    }
                    .frame(width: 300,height: 300)
                }
             TextField("Describe la imagen que quieres generar",
                       text: $text,
                       axis: .vertical)
             .lineLimit(10)
             .lineSpacing(5)
                
                HStack{
                    Spacer()
                    Button("Genera Imagen"){
                        Task{
                            await viewModel.generateImage(withText: text)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(false)
                    .padding(.vertical)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    GenerateView()
}
