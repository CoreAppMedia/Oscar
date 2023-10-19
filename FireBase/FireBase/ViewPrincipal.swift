//
//  ViewPrincipal.swift
//  FireBase
//
//  Created by Oscar Valdes on 18/10/23.
//

import SwiftUI
import Firebase

struct ViewPrincipal: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @State private var nombre = ""
    @State private var apellidoP = ""
    @State private var apellidoM = ""
    
    @State private var usuarioTexto: String = ""
    // Variable calculada que contiene el código
    var nombreDeUsuario: String {
        return authenticationViewModel.user?.email ?? "Miriam@gmail.com"
    }
    
    var body: some View {
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
            VStack {
                Text("Nombre: \(nombre)")
                Text("Apellido Paterno: \(apellidoP)")

                Button("Consultar Documento 'Info'") {
                    consultarDocumentoInfo()
                }
            }
        }
        .onAppear {
            // Actualizar la variable usuarioTexto cuando se carga la vista
            usuarioTexto = nombreDeUsuario
        }
    }
    
    func consultarDocumentoInfo() {
        
        let db = Firestore.firestore()

        // Nombre de la colección
        let nombreColeccion = "Usuarios"

        // Nombre del documento que deseas consultar
       // let nombreDocumento = "Israel@gmail.com"

        db.collection(nombreColeccion).document(usuarioTexto).getDocument { (document, error) in
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
