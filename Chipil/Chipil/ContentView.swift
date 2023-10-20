//
//  ContentView.swift
//  Chipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//

import SwiftUI
import CoreData

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
    
    
    
    @State var AnimacionFInalizar: Bool = false
    @State var RemoverAnimacion: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                Text("Chipil")
                    .font(.largeTitle)
                    .tint(.primary)
              Image("chipil")
                    .resizable().frame(width: 200 ,height: 200, alignment: .center)
                        .clipShape(Circle())
                        .shadow(radius: 10)
              
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
                    RegistroEmailView(authenticationViewModel: authenticationViewModel)
                case .login:
                    IngresoEmailView(authenticationViewModel: authenticationViewModel)
                }
            }
            ZStack{
                Color("blue1").ignoresSafeArea()
                ZStack{
                  
                    if !RemoverAnimacion{
                        VStack{
                            Image("nombre").resizable().frame(width: 420 ,height: 120, alignment: .center)
                            Image("ChipilPortada").resizable().frame(width: 200 ,height: 300, alignment: .center)
                        }//llave del VStack
                    }
                }//llave ZStack

                        }//llave ZStack final
                        .opacity(AnimacionFInalizar ? 0 : 1)
            
            
            
        }
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            withAnimation(.easeInOut(duration: 0.7)){
                                AnimacionFInalizar = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                RemoverAnimacion = true
                            }
                        }
                    }
        
    }//llave del body
    
}//llave principal
#Preview {
    ContentView(authenticationViewModel: AuthenticationViewModel())
}
