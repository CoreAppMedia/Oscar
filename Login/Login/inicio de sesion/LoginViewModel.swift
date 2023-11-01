//
//  LoginViewModel.swift
//  Login
//
//  Created by mac20@ioslabacatlan.appleid.com on 01/11/23.
//


import SwiftUI
import LocalAuthentication
import FirebaseAuth
import Firebase

class LoginViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    //variables para las alertas
    @Published var alert = false
    @Published var alertMsg = ""
    //estas variables las usaremos para extraer los datos del Usuario
    @AppStorage("stored_User") var Stored_user = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    @AppStorage("status") var logged = false
    @Published var store_Info = false
    @Published var isLoading = false
    
    //funcion para los datos biometricos
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        if email == Stored_user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: . none){
            return true
        }
        return false
    }
    func authenticateUser(){
        let scanner = LAContext()
        
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(email)"){ (status, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            //establecer el usuario y contraseña e iniciar sesion
            DispatchQueue.main.async {
                self.password = self.Stored_Password
                self.verifyUser()
            }
            
        }
    }
    
    func verifyUser(){
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password){ (res, err) in
            
            self.isLoading = false
            if let error = err{
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }
            
            //acceso concedido
            //preguntar si quieren que se guarden sus datos
            if self.Stored_user == "" || self.Stored_Password == ""{
                self.store_Info.toggle()
                return
            }
            //entonces ve al inicio del login
            withAnimation{self.logged = true}
        }
    }
}
