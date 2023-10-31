//
//  Hospitales.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 30/10/23.
//

import SwiftUI

struct Hospitales: View {
    var body: some View {
        ZStack{
            Color("chipil").opacity(1).edgesIgnoringSafeArea(.all)//cambiar de color en fondo
            Image("portada2").shadow(radius: 5).offset(y: -350).opacity(0.5)
            Image("ayudante").frame(width: 300, height: 300).offset(x: 0,y: 300).shadow(radius: 5).opacity(0.5)
            
            VStack{
                VStack{
                    Text("HOSPITALES CDMX").font(.title).fontWeight(.black).shadow(color: .white, radius: 15)
                        .padding()
                    
                    Link(destination:  URL(string: "https://goo.gl/maps/731avi2rb6qxDRPk6")!){
                        HStack{
                            Image(systemName: "signpost.right.circle").foregroundColor(.black)
                            
                            Text("Hospital Psiquiátrico Fray Bernardino Álvarez").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                        }
                        
                        
                        
                    }
                    .padding()
                    
                    
                    VStack{
                        Link(destination:  URL(string: "https://goo.gl/maps/161Ku2eX4TeV1K7LA")!){
                            HStack{
                                Image(systemName: "signpost.right.circle")
                                    .foregroundColor(.black)
                                Text("Hospital Psiquiátrico Infantil Juan N. Navarro").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                            }
                            
                        }
                        .padding()
                    }
                    
                    Link(destination:  URL(string: "https://goo.gl/maps/KpW1VEGCwE9AXuUm9")!){
                        HStack{
                            Image(systemName: "signpost.right.circle").foregroundColor(.black)
                            Text("Hospital General de México").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                        }
                        
                    }
                    .padding()
                    
                    Link(destination:  URL(string: "https://goo.gl/maps/TEaYGraAtC2AYa9q9")!){
                        HStack{
                            Image(systemName: "signpost.right.circle").foregroundColor(.black)
                            Text("Hospital Psiquiátrico Fray Juan de Dios").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                        }
                        
                    }
                    .padding()
                }
                
                //finn
                Text("HOSPITALES EDOMEX").font(.title).fontWeight(.black)
                    .padding().shadow(color: .white, radius: 15)
                
                
                Link(destination:  URL(string: "https://goo.gl/maps/q3gX1X1jgTxMgAZp9")!){
                    HStack{
                        Image(systemName: "signpost.right.circle").foregroundColor(.black)
                        Text("Hospital Psiquiátrico Dr.Samuel Ramírez Moreno ").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                    }
                    
                }
                .padding()
                
                Link(destination:  URL(string: "https://goo.gl/maps/m6iWoypmkLebPWgx5")!){
                    HStack{
                        Image(systemName: "signpost.right.circle").foregroundColor(.black)
                        Text("Hospital Psiquiátrico Fray Bernardino Álvarez").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                    }
                    
                }
                .padding()
                
                Link(destination:  URL(string: "https://goo.gl/maps/ua6mzwXQzK65e55M8")!){
                    HStack{
                        Image(systemName: "signpost.right.circle")
                            .foregroundColor(.black)
                        Text("Hospital Psiquiátrico José Torres Orozco").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                    }
                    
                }
                .padding()
                
                Link(destination:  URL(string: "https://goo.gl/maps/QdfSQXU6ZS3hfoHa9")!){
                    HStack{
                        Image(systemName: "signpost.right.circle")
                            .foregroundColor(.black)
                        Text("Hospital Psiquiátrico San Juan de Dios").font(.subheadline).fontWeight(.heavy).foregroundColor(.black)
                    }
                    
                }
                
                .padding()
            }//FIN
        }//zstack final
    }
}

#Preview {
    Hospitales()
}
