//
//  ContentView.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI
//vamos a crrear un enum para poder seleccionar casos
enum Autenticar: String, Identifiable {
    
    case registro
    case login
    
    var id:String{
        return rawValue
    }
}

struct ContentView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var AutenticationSheetView: Autenticar?
    var body: some View {
        VStack {
          Image(systemName: "person.fill")
                .resizable()
                .frame(width: 200, height: 200)
            VStack{
                Button{
                    AutenticationSheetView = .login
                }label: {
                    Label("Entra con Email", systemImage: "envelope.fill")
                }
                .tint(.black)
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 40)
            Spacer()
            HStack{
                Button{
                    AutenticationSheetView = .registro
                }label: {
                    Text("No tienes cuenta?")
                    Text("Registrate")
                        .underline()
                }
                .tint(.black)
            }
        }// llave Vstack 1
        .sheet(item: $AutenticationSheetView){ sheet in
            switch sheet {
            case .registro:
                RegisterEmailView(authenticationViewModel: authenticationViewModel)
            case .login:
                LoginEmailView(authenticationViewModel: authenticationViewModel)
            }
        }
        .preferredColorScheme(.light)
        
    }//llave del body
    
}//llave principal
#Preview {
    ContentView(authenticationViewModel: AuthenticationViewModel())
}
