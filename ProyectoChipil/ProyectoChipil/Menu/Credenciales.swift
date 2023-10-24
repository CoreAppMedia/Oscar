//
//  Credenciales.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 24/10/23.
//

import SwiftUI

struct Credenciales: View {
    var body: some View {
        ZStack{
            Color("chipil").opacity(1).edgesIgnoringSafeArea(.all)//cambiar de color en fondo
            VStack{
                Image("FESA").resizable().aspectRatio( contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .shadow(radius: 5)
                
                Divider()
                Text("Diseñadora grafica").font(.title).fontWeight(.black)
                    .shadow(radius: 5)
                Text("Avilez Pedroza ivon Dulce Anahí")
                    .fontWeight(.bold)
                Divider()
                Text("Programadores").font(.title).fontWeight(.black)
                    .shadow(radius: 5)
                Text("Moreno Robles Miriam").fontWeight(.bold)
                Text("Mejia Jacobo Ximena Juana").fontWeight(.bold)
                Text("Rios Avilès Dana Ixchel").fontWeight(.bold)
                Text("Valdes Rodriguez Oscar Roberto").fontWeight(.bold)
                   
                
            }
        }
    }
}

#Preview {
    Credenciales()
}
