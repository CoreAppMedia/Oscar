//
//  HomePrueba.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 01/11/23.
//

import SwiftUI
import Firebase

struct HomePrueba: View {
    @AppStorage("status") var logged = false
    var body: some View {
        VStack(spacing: 15){
            Text("Usuario activo: \(Auth.auth().currentUser?.email ?? "")")
            Text("ID del Usuario: \(Auth.auth().currentUser?.uid ?? "")")
            
            Button(action: {
                try! Auth.auth().signOut()
                withAnimation{logged = false}
            }, label: {
                Text("Salir")
                    .fontWeight(.heavy)
            })
        }
    }
}

#Preview {
    HomePrueba()
}
