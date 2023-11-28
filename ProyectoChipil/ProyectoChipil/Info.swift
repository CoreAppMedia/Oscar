//
//  Info.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 28/11/23.
//

import SwiftUI

struct Info: View {
    var body: some View {
          VStack {
              Spacer()
              Image("premium")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 300, height: 300)
              Text("¡Conviértete en Premium!")
                  .font(.title)
                  .foregroundColor(.white)
                  .fontWeight(.bold)
                  .padding()
              
              Text("Obtén acceso a funciones exclusivas y beneficios especiales.")
                  .foregroundColor(.white)
                  .padding()
              
              Button(action: {
                  // Aquí puedes agregar la lógica para manejar la acción de convertirse en premium
              }) {
                  Text("Mejora a Premium")
                      .foregroundColor(.white)
                      .padding()
                      .background(Color.green)
                      .cornerRadius(10)
              }
              Spacer()
          }.background(Color("chipil").ignoresSafeArea(.all, edges: .all))
        
          .padding(-20)
      }
  }



#Preview {
    Info()
}
