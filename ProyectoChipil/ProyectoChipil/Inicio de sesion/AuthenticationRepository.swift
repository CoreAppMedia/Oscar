//
//  AuthenticationRepository.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//

import Foundation

final class AuthenticationRepository{
    
    private let authenticationFirebaseDatasource: AuthenticatinFirebaseDatasourse
    
    init(authenticationFirebaseDatasource: AuthenticatinFirebaseDatasourse = AuthenticatinFirebaseDatasourse()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func getCurrentUser() -> User?{
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        authenticationFirebaseDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    func login(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        authenticationFirebaseDatasource.login(email: email, password: password, completionBlock: completionBlock)
    }
    
    func logout() throws{
        try authenticationFirebaseDatasource.logout()
    }
    /*funcion de prueba para Autenticar y mandar correo de verificacion
    class AuthService {
        static let shared = AuthService()
        let authenticationFirebaseDatasource = AuthenticationFirebaseDatasource()

        func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void) {
            authenticationFirebaseDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
        }
    }*/
}
