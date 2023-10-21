//
//  BaseView.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 21/10/23.
//

import SwiftUI

struct BaseView: View {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    @State var ShowMenu: Bool = false
    //ocultar un nativo
    
    //variable para seleccionar una View
    @State var currentTab = "Home"
    
//offset para arrastrar gesuture y mostrar Menú
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    //Desplazamiento del gesto
    @GestureState var gestureOffset: CGFloat = 0
    
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 90
        
        
        //vista de la navegacion completa
        NavigationView{
            HStack(spacing: 0){
                //Menu lateral
                VStack(alignment: .leading, spacing:  0){
                    VStack(alignment: .leading, spacing: 14){
                        
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                        Text("Optimus")
                            .font(.title2.bold())
                        Text("@Optimus")
                            .font(.callout)
                        HStack(spacing: 12){
                            
                            Button{
                                
                            }label: {
                                Label(
                                    title: { Text("Seguidos") },
                                    icon: { Image(systemName: "42.circle")}
                                )
                            }//termina boton
                            
                            Button{
                                
                            }label: {
                                Label(
                                    title: { Text("Seguidores") },
                                    icon: { Image(systemName: "18.circle")}
                                )
                            }//termina boton
                            
                        }// HStack donde esatn los botones de seguidores y seguidos
                        .foregroundColor(.primary)
                    }//VStack del contenido en el rectangulo lateral
                    .padding(.horizontal)
                    .padding(.leading)
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            VStack(alignment: .leading, spacing: 38){
                                
                                TabButton(title: "Perfil", image: "person.fill")
                                TabButton(title: "Lista", image: "person")
                                TabButton(title: "Temas", image: "person.fill")
                                TabButton(title: "Consejos", image: "person")
                                TabButton(title: "Momentos", image: "person.fill")
                                TabButton(title: "Tus MeGusta", image: "person")
                                TabButton(title: "Bloqueos", image: "person.fill")
                                
                            }//VStack de los botones
                            .padding()
                            .padding(.leading)
                            .padding(.top, 35)
                            
                            Divider()
                            TabButton(title: "Anuncios", image:"square.and.arrow.up")
                                .padding()
                                .padding(.leading)
                            Divider()
                            VStack(alignment: .leading, spacing: 25){
                                Button("Ajustes y privacidad"){
                                    
                                }
                                Button("Centro de ayuda"){
                                    
                                }
                            }//vstack
                            .padding()
                            .padding(.leading)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        }//VStack
                    }// ScrollView contenido en el rectangulo lateral
                    
                    VStack(spacing: 0){
                        Divider()
                        HStack{
                            //cambiar ppr iun navigationLink cuando se requiera ir a otra View, se dejo en Button para que no marcara error ya que por el momento no direcciona a ninguna view
                            Button{
                                authenticationViewModel.logout()
                            }label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 22, height: 22)
                                Text("Cerrar Sesión")
                            }
                        }//HStack
                        .padding([.horizontal, .top], 15)
                        .foregroundColor(.primary)
                    }//VStack
                }// VStack principal creando el rectangulo lateral
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                //Anchura máxima
                .frame(width: getRect().width - 90)
                .frame(maxHeight: .infinity)
                .background(
                    Color.primary
                        .opacity(0.09)
                        .ignoresSafeArea(.container, edges: .vertical))
                .frame(maxWidth: .infinity, alignment: .leading)
                // Vista de la pestaña Principal
                VStack(spacing:0){
                    TabView(selection: $currentTab){
                        //Este "Text" se repetira dependiendo el  numero de botones que etengan en el menu lateral(SideMenu), en este caso son 7
                        Text("Home")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("house")
                    }//TabView

                }//VStack
                .frame(width: getRect().width)
                //BG cuando se muestra el menú
                .overlay(
                Rectangle()
                    .fill(
                        Color.primary
                            .opacity(Double((offset / sideBarWidth)/5))
                    )
                    .ignoresSafeArea(.container, edges: .vertical)
                    .onTapGesture {
                        withAnimation{
                            ShowMenu.toggle()
                        }
                    })
                
            }
            //tamaño máximo
            .frame(width: getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x:offset > 0 ? offset: 0)
            //Desplazamiento del gesto
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value:))
            )
            //sin título en la barra de navegación
            //ocultar barra de navegación
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }//NavigationView
        .animation(.easeOut, value: offset == 0)
        .onChange(of: ShowMenu){ newValue in
            
            if ShowMenu && offset == 0{
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            if !ShowMenu && offset == sideBarWidth{
                offset = 0
                lastStoredOffset = 0
            }
            
        }
        .onChange(of: gestureOffset){ newValue in
            onChange()
        }
    }
    func onChange(){
        
        let sideBarWidth = getRect().width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideBarWidth ? gestureOffset + lastStoredOffset : offset): offset
    }
    
    func onEnd(value: DragGesture.Value){
        let sideBarWidth = getRect().width - 90
        let translation = value.translation.width
        
        withAnimation{
            if translation > 0{
                if translation > (sideBarWidth / 2){
                    //Mostrar menu
                    offset = sideBarWidth
                    ShowMenu = true
                }else{
                    //casos extra
                    if offset == sideBarWidth{
                        return
                    }
                    offset = 0
                    ShowMenu = false
                }
            }else{
                if -translation > (sideBarWidth / 2){
                    offset = 0
                    ShowMenu = false
                }else{
                    if offset == 0 || !ShowMenu{
                        return
                    }
                    offset = sideBarWidth
                    ShowMenu = true
                }
                
            }
        }
        
        //almacenar el ultimo dezplazamiento
        lastStoredOffset = offset
        
        
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String)->some View{
        
        NavigationLink{
            Text("\(title) Master")
                .navigationTitle((title))
        }label: {
            HStack(spacing: 14){
                
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }//Termina Funcion

    
}

#Preview {
    BaseView()
}

// extending view to get screen rect
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

/*
 palabras clave:
 main   = Principal
 bounds = limites
 palabras clave:
 
 whole = todo
 tag   = etiqueta
 hidden = oculto
 DragGesture = arrastrar gesto
 side Bar Width = ancho de la barra lateral
 gesture Offset = desplazamiento del gesto
 storing last offset = almacenar el ultimo dezplazamiento
 width = ancho

*/
