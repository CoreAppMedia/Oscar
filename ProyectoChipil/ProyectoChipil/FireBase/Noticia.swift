//
//  Noticia.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 25/10/23.
//

import SwiftUI

struct Noticia: View {
    @ObservedObject var LinkViewModel: LinkViewModel
    var body: some View {
                List{
                    ForEach(LinkViewModel.links){ link in
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Text("Titulo:")
                                    .bold()
                                    .lineLimit(4)
                                Text("\(link.titulo)")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)
                                Spacer()
                                Button(action: {
                                    LinkViewModel.updateIsFavorited(link: link)
                                }, label: {
                                    if link.like{
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .foregroundColor(.yellow)
                                            .frame(width: 25, height: 25)
                                    }
                                })
                            }
                            HStack{
                                Text("Noticia: ")
                                    .bold()
                                    .lineLimit(4)
                                Text("\(link.noticia)")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)

                            }
                            HStack{
                                Text("Fecha: ")
                                    .bold()
                                    .lineLimit(4)
                                Text("\(link.fecha)")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }
                            Divider().background(.black)
                        }//Vstack
                    }//fin fel ForEach
                }//Fin de la lista
                .task {
            LinkViewModel.getAllLink()
        }
    }
}

#Preview {
    Noticia(LinkViewModel: LinkViewModel())
}
