//
//  prueba-login.swift
//  ProyectoChipil
//
//  Created by mac20@ioslabacatlan.appleid.com on 30/10/23.
//

import SwiftUI
import LocalAuthentication

struct Login: View {
    @StateObject var LoginModel = LoginViewModel()
    @AppStorage("stored_User") var Stored_user = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    @AppStorage("status") var logged = false
    var body: some View {
        
        ZStack{
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
                    TextField("Email", text: $LoginModel.email)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(LoginModel.email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack{
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Password", text: $LoginModel.password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(LoginModel.password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15){
                    Button(action: LoginModel.verifyUser, label:{
                        Text("Entrar")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color.green)
                            .clipShape(Capsule())
                    })
                    
                    .opacity(LoginModel.email != "" && LoginModel.password != "" ? 1 : 0.5)
                    .disabled(LoginModel.email != "" && LoginModel.password != "" ? false : true)
                    .alert(isPresented: $LoginModel.alert, content: {
                        Alert(title: Text("Error Master"), message: Text(LoginModel.alertMsg), dismissButton: .destructive(Text("OK master")))
                    })
                    if LoginModel.getBioMetricStatus(){
                        Button(action: LoginModel.authenticateUser, label:{
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
                .padding(.top, 8)
                .alert(isPresented: $LoginModel.store_Info, content: {
                    Alert(title: Text("Messenge"), message: Text("Quieres guardar tus datos biometriocos para futuros ingresos master?"), primaryButton:
                            .default(Text("Aceptar"), action: {
                                
                                Stored_user = LoginModel.email
                                Stored_Password = LoginModel.password
                                
                                withAnimation{self.logged = true}
                            }), secondaryButton: .cancel({
                                withAnimation{self.logged = true}
                            }))
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
            if LoginModel.isLoading{
                LoadingScreen()
            }
        }
    }
}
