//
//  ViewPrincipal.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import SwiftUI
import LocalAuthentication
struct ViewPrincipal: View {
    @AppStorage("status") var logged = false
    
    var body: some View {
        NavigationView{
            if logged{
                Text("User Logged In....")
                    .navigationTitle("Home Master")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            }else{
                Home1()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
                
            }
        }
    }
}
#Preview {
    ViewPrincipal()
}

struct Home1: View {
    @State var userName = ""
    @State var password = ""
    
    @AppStorage("stored_User") var user = "Oscar@gmail.com"
    @AppStorage("status") var logged = false
    var body: some View {
        VStack{
            Spacer(minLength: 0)
            Image("Chipil")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(.vertical)
            HStack{
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Login Master")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Porfavor inicie para continuar")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                
                Spacer(minLength: 0)
            }
            .padding()
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                TextField("Email", text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15){
                Button(action: {}, label:{
                    Text("Entrar")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color.green)
                        .clipShape(Capsule())
                })
                
                .opacity(userName != "" && password != "" ? 1 : 0.5)
                .disabled(userName != "" && password != "" ? false : true)
                
                if getBioMetricStatus(){
                    Button(action: authenticateUser, label:{
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                }
            }
            .padding(.top)
            
            Button(action: {}, label:{
                Text("¿olvidaste tu contraseña?")
                    .foregroundColor(Color.white.opacity(0.6))
            })
            Spacer(minLength: 0)
            
            HStack(spacing: 6){
                Text("¿No tienes cuenta?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {}, label:{
                    Text("Registrate")
                        .foregroundColor(Color.green)
                })
            }
            
            
        }
        .background(Color("chipil").ignoresSafeArea(.all, edges: .all))
        .animation(.easeOut)
    }
    
    //funcion para los datos biometricos
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: . none){
            return true
        }
        return false
    }
    
    func authenticateUser(){
        let scanner = LAContext()
        
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(userName)"){ (status, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            withAnimation(.easeOut){logged = true}
            
        }
        
        
    }
    
    
}
