//
//  Perfil1.swift
//  FireBase
//
//  Created by mac20@ioslabacatlan.appleid.com on 19/10/23.
//

import SwiftUI
import Firebase

struct Perfil1: View {
    @State private var nombre = ""
    @State private var apellidoP = ""
    @State private var apellidoM = ""
    
    var body: some View {
        VStack {
            Text("Nombre: \(nombre)")
            Text("Apellido Paterno: \(apellidoP)")

            Button("Consultar Documento 'Info'") {
                consultarDocumentoInfo()
            }
        }
    }
    
    func consultarDocumentoInfo() {
        let db = Firestore.firestore()

        // Nombre de la colección
        let nombreColeccion = "Usuarios"

        // Nombre del documento que deseas consultar
        let nombreDocumento = "Israel@gmail.com"

        db.collection(nombreColeccion).document(nombreDocumento).getDocument { (document, error) in
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
    Perfil1()
}
