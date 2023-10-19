//
//  PerfilStruct.swift
//  FireBase
//
//  Created by mac20@ioslabacatlan.appleid.com on 18/10/23.
//

import SwiftUI
//Modelo de la informacion de los ciestionarios
struct Info: Codable{
    var title: String
    var peopleAttended: Int
    var rules:[String]
    
    enum CodingKeys: CodingKey {
        case title
        case peopleAttended
        case rules
    }
}

struct PerfilData: Codable{
    let nombre: String
    let apellidoP: String
    let apellidoM: String
    let descripcion: String
    let titulo: String
    let numeroTel: String
    
    
    enum CodingKeys: CodingKey{
        
        case nombre
        case apellidoP
        case apellidoM
        case descripcion
        case titulo
        case numeroTel
        
    }
    
    
}


import SwiftUI
import Firebase

    // ...

    func agregarDocumentoInfoAColeccion() {
        let db = Firestore.firestore()
        
        // Nombre de la colección
        let nombreColeccion = "miNuevaColeccion"

        // Datos del documento "Info"
        let datosDocumento = [
            "nombre": "John",
            "apellidoPaterno": "Doe",
            // Agrega más campos y valores según tus necesidades
        ]

        // Agregar el documento "Info" a la colección
        db.collection(nombreColeccion).document("Info").setData(datosDocumento) { error in
            if let error = error {
                print("Error al agregar el documento 'Info': \(error.localizedDescription)")
            } else {
                print("Documento 'Info' agregado con éxito a la colección \(nombreColeccion)")
            }
        }
    }

    var body: some View {
        // Tu interfaz de usuario y un botón para activar la función agregarDocumentoInfoAColeccion
        Button("Agregar Documento 'Info' a Colección") {
            agregarDocumentoInfoAColeccion()
        }
    }


