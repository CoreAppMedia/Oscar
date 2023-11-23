//
//  AuthenticationFirebaseDataSource.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticatinFirebaseDatasourse {
    
    //metodo para que si hay una sesion iniciada se muestre al inicical la App
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else{
            return nil
        }
        
        return.init(email: email)
    }
    
    //funcion para crear el usuario
    func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){ authDataResult, error in
            
            if let error = error {
                print("Error al crear nuevo usuario\(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let email = authDataResult?.user.email ?? "no email"
            print(" Nuevo Usuario creado con el correo: \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    

    
    //funcion para iniciar el usuario ya registrado
    func login(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){ authDataResult, error in
            
            if let error = error {
                print("Error al iniciar sesion\(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let email = authDataResult?.user.email ?? "no email"
            print(" Sesion iniciada con: \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    
    
    // metodo para cerrar la sesion
    func logout() throws{
        try Auth.auth().signOut()
    }
    
    
    
    //funcion de prueba para Autenticar y mandar correo de verificacion
    class AuthService {
        static let shared = AuthService()

        func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
            Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in

                if let error = error {
                    print("Error al crear nuevo usuario: \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                // Send email verification
                authDataResult?.user.sendEmailVerification(completion: { verificationError in
                    if let verificationError = verificationError {
                        print("Error al enviar el correo de verificación: \(verificationError.localizedDescription)")
                        completionBlock(.failure(verificationError))
                    } else {
                        let email = authDataResult?.user.email ?? "no email"
                        print("Nuevo Usuario creado con el correo: \(email). Se ha enviado un correo de verificación.")
                        completionBlock(.success(.init(email: email)))
                    }
                })
            }
        }
    }
    

    
    
}
