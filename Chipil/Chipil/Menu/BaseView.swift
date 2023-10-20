//
//  BaseView.swift
//  Chipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//
import SwiftUI

struct BaseView: View {
    @State var ShowMenu: Bool = false
    //ocultar un nativo
    init(){
        UITabBar.appearance().isHidden = true
    }
    
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
                SideMenu(showMenu: $ShowMenu)
                // Vista de la pestaña Principal
                VStack(spacing:0){
                    TabView(selection: $currentTab){
                        //Este "Text" se repetira dependiendo el  numero de botones que etengan en el menu lateral(SideMenu), en este caso son 7
                        Text("Home")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Notificaciones")
                        Text("notificaciones")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("magnifyingglass")
                        Text("notificaciones")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("app")
                        Text("Mensajes")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("message")
                    }//TabView
                    
                    VStack(spacing:0){
                        Divider()
                        HStack(spacing:0){
                            TabButton(image: "house")
                            TabButton(image: "magnifyingglass")
                            TabButton(image: "app")
                            TabButton(image: "message")
                            
                        }//HStack de los botones para seleccionar una View principal
                        .padding([.top],15)
                    }

                    
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
    func TabButton(image: String)->some View{
        Button{
            withAnimation{currentTab = image}
        }label: {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .foregroundColor(currentTab == image ? .primary : .gray)
                    .frame(maxWidth: .infinity)
        }
    }//Termina Funcion
    
}

#Preview {
    BaseView()
}

/*
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
