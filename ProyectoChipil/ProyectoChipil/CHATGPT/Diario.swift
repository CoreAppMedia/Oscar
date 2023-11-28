//
//  JournalEntry.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 28/11/23.
//

import SwiftUI

struct Diario: View {
    @State private var nuevoContenido: String = ""
    @State private var contenidoActualizado: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
          
            HStack{
                VStack{
                    Text("Pensamientos")
                        .font(.title)
                        .padding(.leading)
                    Text("del Día")
                        .font(.title)
                        .padding(.leading)
                }
                Spacer()
                Image("chipil chat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.trailing)
            }
            Divider()

            Text("Hoy, mientras el sol se despedía...")
                .font(.body)
                .padding(.leading)

            // TextField para agregar contenido
            TextField("Agrega tu reflexión aquí", text: $nuevoContenido)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 8)
                .padding(.leading)
                .padding(.trailing)

            // Botón de actualización
            Button(action: {
                // Actualiza el contenido cuando se presiona el botón
                contenidoActualizado = nuevoContenido
            }) {
                Text("Enviar")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding(.leading)

            // Muestra el contenido actualizado
            if !contenidoActualizado.isEmpty {
                Text("Contenido Actualizado:")
                    .font(.headline)
                Text(contenidoActualizado)
                    .font(.body)
            }

            Spacer()
        }
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
        
    }
}

#Preview {
    Diario()
}
