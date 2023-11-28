//
//  BaseView.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 21/10/23.
//

import SwiftUI

struct BaseView: View {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    @ObservedObject var LinkViewModel: LinkViewModel
    //ocultar o mostrar el menu lateral
    @State var ShowMenu: Bool = false
    //variable para seleccionar una View
    @State var currentTab = "Home"
//offset para arrastrar gesuture y mostrar Menú
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    //Desplazamiento del gesto
    @GestureState var gestureOffset: CGFloat = 0
    
    @State private var value = ""
    @State private var perfilData_1: PerfilData?
    
    var nombreDeUsuario: String {
        return authenticationViewModel.user?.email ?? "Ixchell@gmail.com"
    }
    
    @State private var usuarioTexto: String = ""
    
    @State var isModal: Bool = false
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 90
        
        
        //vista de la navegacion completa
NavigationView{
    HStack(spacing: 0){
        // Inicia Menu lateral
        VStack(alignment: .leading, spacing:  0){
            VStack(alignment: .leading, spacing: 14){
                Image("icono")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.black, lineWidth: 1)
                    }
                VStack(alignment: .leading, spacing: 0){
                    Text("Bienvenido")
                        .font(.callout)
                    Text(usuarioTexto)
                        .font(.title2.bold())
                    }
                    HStack(spacing: 12){
                        Button{
                            }label: {
                            Label(
                                title: { Text("Seguidos") },
                                icon: { Image(systemName: "42.circle")}
                                )}//termina boton
                        Button{
                            }label: {
                            Label(
                                title: { Text("Seguidores") },
                                icon: { Image(systemName: "18.circle")}
                                )}//termina boton
                        }// HStack donde esatn los botones de seguidores y seguidos
                        .foregroundColor(.primary)
                    }//VStack del contenido en el rectangulo lateral
                    .padding(.horizontal)
                    .padding(.leading)
                    
            ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        VStack(alignment: .leading, spacing: 38){
                            NavigationLink(){
                                PerfilUsuario(authenticationViewModel: AuthenticationViewModel(), value: .constant( usuarioTexto)).preferredColorScheme(.light)
                                }label: {
                                HStack(spacing: 14){
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 22, height: 22)
                                        Text("perfil")
                                    }
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            NavigationLink(){
                                HomeAnsiedad(authenticationViewModel: AuthenticationViewModel(), value: .constant(""))
                                }label: {
                                HStack(spacing: 14){
                                    Image(systemName: "person")
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 22, height: 22)
                                        Text("Cuestionario")
                                    }
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                NavigationLink(){
                                    Llamadas()
                                }label: {
                                    HStack(spacing: 14){
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 22, height: 22)
                                        Text("Agenda")
                                    }
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            NavigationLink(){
                                Hospitales()
                            }label: {
                                HStack(spacing: 14){
                                    Image(systemName: "person")
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 22, height: 22)
                                    Text("Hospitales")
                                }
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
    
                        
                            }//VStack de los botones
                            .padding()
                            .padding(.leading)
                            .padding(.top, 35)
                            
                            Divider()
                        NavigationLink(){
                           Info()
                        }label: {
                            HStack(spacing: 14){
                                
                                Text("Haste Premium")
                                Image(systemName: "star.circle.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 22, height: 22)
                            }
                            .padding(.leading, 70)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.primary)
                        }
                            Divider()
                            VStack(alignment: .leading, spacing: 25){
                                
                                Button("Creadores") {
                                     self.isModal = true
                                 }.sheet(isPresented: $isModal, content: {
                                     Credenciales()
                                 }).foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
                            //Boton para salir de la APP t regresar al login
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
                    Color.chipil
                        .opacity(0.7)
                        .ignoresSafeArea(.container, edges: .vertical))
                .frame(maxWidth: .infinity, alignment: .leading)
                .onAppear {
                    // Actualizar la variable usuarioTexto cuando se carga la vista
                    usuarioTexto = nombreDeUsuario
                }
                //termina menu lateral
                
                // Vista de la pestaña Principal
                VStack(spacing:0){
                    TabView(){
                        VStack{
                        //Empieza vista principal de la APP
                            HStack{
                                Button{
                                    withAnimation{ShowMenu.toggle()}
                                }label: {
                                    Image("icono")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay{
                                            Circle().stroke(.black, lineWidth: 1)
                                        }
                                }
                                .padding(.leading)
                                Spacer()
                                    Text("Bienvenidos")
                                    .font(.title2)
                                        .padding(.leading, 20)
                                        .offset(x: 10)
                               
                                
                                Button(action: {
                                    guard let phoneNumber = URL(string: "tel://8009112000") else { return }
                                    UIApplication.shared.open(phoneNumber)
                                }) {
                                    Image("emergencia")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 140, height: 30)
                                    
                                   //     .shadow(color: .blue, radius:10)
                                }
                               // .padding(.trailing)
                                }
                            .padding(.bottom)
                            .background(
                                    Color.chipil
                                        .opacity(0.7)
                                        .ignoresSafeArea(.container, edges: .vertical))
                            HStack{
                                NavigationLink(){
                                  Diario()
                                    }label: {
                                    VStack{
                                        Image("expediente")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                            .overlay{
                                                Circle().stroke(.black, lineWidth: 2)
                                            }
                                        Text("Diario")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.top, -5)
                                    }
                                }
                                Spacer()
                                NavigationLink(){
                                    ChatBotView()
                                        .navigationBarTitle("ChatChipil")
                                    }label: {
                                    VStack{
                                        Image("Group 1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                            .overlay{
                                                Circle().stroke(.black, lineWidth: 2)
                                            }
                                        Text("Hablame")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.top, -5)
                                    }
                                }
                                Spacer()
                                NavigationLink(){
                                    Home(authenticationViewModel: AuthenticationViewModel(), value: .constant(""))
                                    }label: {
                                        VStack{
                                            Image("pdf")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                                .overlay{
                                                    Circle().stroke(.black, lineWidth: 2)
                                                }
                                            Text("Test")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .padding(.top, -5)
                                        }
                                    }
                          
                            }
                            .padding(.leading,50)
                            .padding(.trailing,50)
                            List{
                                ForEach(LinkViewModel.links){ link in
                                    VStack(alignment: .leading, spacing: 5){
                                        HStack {
                                            Image("mural2")
                                                .resizable()
                                                .frame(width: 100, height: 100) // Ajustamos la imagen
                                                .clipShape(RoundedRectangle(cornerRadius: 10)) // Redondea las esquinas de la imagen
                                            
                                            Text(link.titulo).font(.title).bold()
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5) // Agrega una sombra solo en la parte inferior
                                        .padding(.vertical, 10)
                                    
                                        HStack{
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
                         //Termina Vista principal de la APP
                        }
                    }//TabView
                }//VStack
                .frame(width: getRect().width)
                //BG cuando se muestra el menú
                .overlay(
                Rectangle()
                    .fill(
                        Color.black
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
    }//termina funcion
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
    }//termina funcion
    
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
    BaseView(LinkViewModel: LinkViewModel())
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
