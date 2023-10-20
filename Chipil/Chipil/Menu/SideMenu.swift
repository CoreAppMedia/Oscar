//
//  SideMenu.swift
//  Chipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//
import SwiftUI

struct SideMenu: View {
    @Binding var showMenu: Bool
    var body: some View {
        VStack(alignment: .leading, spacing:  0){
            VStack(alignment: .leading, spacing: 14){
                
                Image("optimus")
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
                        
                    }label: {
                        Image(systemName: "paperclip")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                    }
                    
                    Spacer()
                    Button{
                        
                    }label: {
                        Image(systemName: "qrcode")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
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
            Color.green
                .opacity(0.3)
                .ignoresSafeArea(.container, edges: .vertical))
        .frame(maxWidth: .infinity, alignment: .leading)
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
    ContentView(authenticationViewModel: AuthenticationViewModel())
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
 
 */
