//
//  ViewPrincipal.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI
import Firebase
class UserData: ObservableObject{ //El bservableObject se utiliza para poder actualizar datos complejos, para ello, dichas propiedades debes tener el property Wrapper @published
    
    @Published var name = "Oscar"
    @Published var age = 25
    @Published var nombre = ""
}

struct ViewPrincipal: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @StateObject private var usuario = UserData()//@StateObject se utiliza para establecer un objeto mutable complejo
    
    @State private var nombre = ""
    @State private var apellidoP = ""
    @State private var apellidoM = ""
    
    @State private var usuarioTexto: String = ""
    // Variable calculada que contiene el código
    @State private var seleccion: Int?
    
    var nombreDeUsuario: String {
        return authenticationViewModel.user?.email ?? "Miriam@gmail.com"
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Bienvenido:  \(usuarioTexto)")
                    .font(.title)
                    .fontWeight(.semibold)
                    Button{
                        authenticationViewModel.logout()
                    }label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                
                Text("Mi  Nombre es: \(usuario.nombre)")
                TextField("añade tu correo electrocino",text: $usuario.nombre )
                    .padding()
                Button("Actualizar Datos") {
                     usuario.nombre = usuarioTexto
                    consultarDocumentoInfo()
                    
                }
                VStack {
                    Text("Nombre: \(nombre)")
                    Text("Apellido Paterno: \(apellidoP)")

                }
                NavigationLink(destination: Perfil1(usuario1: usuario), tag: 1, selection: $seleccion){
                    
                    Button("Ir a BindingView") {
                        seleccion = 1
                    }
                }
            }
            .onAppear {
                // Actualizar la variable usuarioTexto cuando se carga la vista
                usuarioTexto = nombreDeUsuario
            }
        }
        

    }
    
    func consultarDocumentoInfo() {
        
        let db = Firestore.firestore()

        // Nombre de la colección
        let nombreColeccion = "Usuarios"

        // Nombre del documento que deseas consultar
     //   let nombreDocumento = "Israel@gmail.com"

        db.collection(nombreColeccion).document(usuario.nombre).getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    nombre = data["nombre"] as? String ?? ""
                    apellidoP = data["apellidoP"] as? String ?? ""
                    apellidoM = data["apellidoM"] as? String ?? ""
                }
            } else {
                print("Documento 'Info' no encontrado o error al consultar: \(error?.localizedDescription ?? "Desconocido")")
            }
        }
    }
    
}

#Preview {
    ViewPrincipal(authenticationViewModel: AuthenticationViewModel())
}
