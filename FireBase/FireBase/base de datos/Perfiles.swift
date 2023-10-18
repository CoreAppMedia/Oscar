//
//  Perfiles.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI

struct Perfiles: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var LinkViewModel: LinkViewModel
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var mostrar: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(LinkViewModel.links){ link in
                        VStack{
                            HStack{
                                Text(link.nombre)
                                    .bold()
                                    .lineLimit(4)
                                Text(link.apellidoP)
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)
                                Text(link.apellidoM)
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }
                            Text(link.descripcion)
                                .bold()
                                .lineLimit(4)
                                .padding(.bottom, 8)
                            HStack{
                                Text("Clasificación: ")
                                Text(link.titulo)
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }

                                Text("Numero de Expediente: \(link.numeroTel)")
                                    .bold()
                                    .foregroundColor(.black)
                                    .font(.caption)
                        }//Vstack
                        .swipeActions(edge: .leading){
                            Button(action: {
                                LinkViewModel.delete(link: link)
                            }, label: {
                                Label("Eliminar", systemImage: "trash.fill")
                            })
                            .tint(.red)
                    }
                        
                        
                    }
                    }.task {
                        LinkViewModel.getAllLink()
            }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Bienvenido \(authenticationViewModel.user?.email ?? "No usuario Master")")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        self.mostrar.toggle()
                    }){
                        Image(systemName: "plus")
                            .resizable().frame(width: 20 ,height: 20)
                    }
                }
                
            }// llave Toolbar
            .sheet(isPresented: self.$mostrar,content: {
                CrearPerfil(LinkViewModel: LinkViewModel)
            })
        }
    }
}

#Preview {
    Perfiles(LinkViewModel: LinkViewModel(), authenticationViewModel: AuthenticationViewModel())
}
