//
//  Llamadas.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 24/10/23.
//

import SwiftUI

struct Llamadas: View {
    
    var body: some View {
        ZStack{
            Color("chipil").opacity(1).edgesIgnoringSafeArea(.all)//cambiar de color en fondo
            Image("ayudante").frame(width: 300, height: 300).offset(x: 0,y: 300).shadow(radius: 5).opacity(0.5)
            VStack{
                    Text("HOSPITALES CDMX")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding(.bottom,20)
                
                LlamadasStack(title: "Hospital Psiquiátrico Fray Bernardino Álvarez", url: "tel://5556554405")
                LlamadasStack(title: "Hospital Psiquiátrico Infantil Juan N. Navarro", url: "tel://5555734866")
                LlamadasStack(title: "Hospital General de México", url: "tel://5527893000")
                LlamadasStack(title: "Hospital Psiquiátrico Fray Juan de Dios", url: "tel://5556554405")
               
                    Text("HOSPITALES EDOMEX")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom,20)
                
                LlamadasStack(title: "Hospital Psiquiátrico Dr. Samuel Ramírez Moreno ", url: "tel://7222150858")
                LlamadasStack(title: "Hospital Psiquiátrico José Torres Orozco ", url: "tel://5557162177")
                LlamadasStack(title: "GRUPO CALTIA PSICOLOGÍA S.C.", url:"tel//5553741515")
                    //con esat funcion nos evitamos escribir codigo de mas
                LlamadasStack(title: "Hospital Psiquiátrico San Juan de Dios", url: "tel://5553583400")
                    Spacer()
            }
        }//llave del zstack
    }//llave del body
    
    //con esta funcion armamos los botones que nos serviran para poder Marcar a diferentes hospitales
    @ViewBuilder
    func LlamadasStack(title: String, url: String)->some View{
        VStack{
            Button(action: {
                guard let phoneNumber = URL(string: url) else { return }
                UIApplication.shared.open(phoneNumber)
            }) {
                Text(title).foregroundColor(Color.black)
            }
        }
        Divider()
    }//Termina Funcion
}//llave final

#Preview {
    Llamadas()
}
