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
    @State var titles = [
     "Ayuda desde casita",
     "Un lugar seguro para ti",
     "Ayuda para tus Emociones"]
    
    @State var subTitles = [
        "Ejercicios - informacion - Ayuda",
        "Telefonos - Alegia - Jugar",
        "Fisica - Emocional - Mamás"]
    //animaciones
    @State var currentIndex: Int = 2
    @State var titleText: [TextAnimation] = []
    @State var subTitleAnimatio: Bool = false
    @State var endAnimation = false
    
    var body: some View {
        ZStack{
            //Tamaño de la pantalla
            GeometryReader{ proxy in
                let size = proxy.size
                
                Color.black
                ForEach(1...3, id: \.self){ index in
                    Image("pic\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .opacity(currentIndex == (index - 1) ? 1 : 0)
                }
                //lineal gradient... osea la sombra de las letras hijo
                LinearGradient(colors: [
                    .clear,
                    .black.opacity(0.5),
                    .black
                
                ], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
            
            //palabras que suben
            VStack(spacing: 20){
                HStack(spacing: 0){
                    ForEach(titleText){ text in
                        Text(text.text)
                            .offset(y: text.offset)
                    }
                    .font(.largeTitle.bold())
                }
                .offset(y: endAnimation ? -100 : 0)
                .opacity(endAnimation ? 0 : 1)
                .foregroundColor(.white)
                Text(subTitles[currentIndex])
                    .opacity(0.7)
                    .offset(y: !subTitleAnimatio ? 80 : 0)
                    .offset(y: endAnimation ? -100 : 0)
                    .opacity(endAnimation ? 0 : 1)
                    .foregroundColor(.white)
                //botones de inicio de sesion aqui
                VStack {
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
                    .padding(.top, 100)
                    .foregroundColor(.white)
                    Spacer()
                    HStack{
                        Button{
                            AutenticationSheetView = .registro
                        }label: {
                            Text("No tienes cuenta?")
                            Text("Registrate")
                                .underline()
                        }
                        .foregroundColor(.white)
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
                
            }
            
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }//zstak imagenes
        .onAppear(perform: {
            currentIndex = 0
        })
        .onChange(of: currentIndex) { newValue in
            // si llega a la ultima foto ps se actualiza
            
            getSpilitedText(text: titles[currentIndex]){
                withAnimation(.easeInOut(duration: 1)){
                    endAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){
                    //mover el texto
                    titleText.removeAll()
                    subTitleAnimatio.toggle()
                    endAnimation.toggle()
                    withAnimation(.easeIn(duration: 0.6)){
                        if currentIndex < (titles.count - 1){
                            currentIndex += 1
                        } else {
                            currentIndex = 0
                        }
                    }
                }
                
            }
        }
    }//home
    // dividir texto en una variedad de caracteres y dividirlo
    func getSpilitedText(text: String, completion: @escaping ()->()){
        for(index,character) in text.enumerated(){
            
            titleText.append(TextAnimation(text: String(character)))
            
            //tiempo de desplazamiento
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03){
                withAnimation(.easeOut(duration: 0.5)){
                    titleText[index].offset = 0
                }
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) * 0.02) {
            withAnimation(.easeInOut(duration: 0.5)){
                subTitleAnimatio.toggle()
            }
            // completion..
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                completion()
            }
        }
        
    }//llave del body
}//llave principal
#Preview {
    ContentView(authenticationViewModel: AuthenticationViewModel())
}

import SwiftUI

struct TextAnimation: Identifiable {
    var id = UUID().uuidString
    var text: String
    var offset: CGFloat = 110
    
}
