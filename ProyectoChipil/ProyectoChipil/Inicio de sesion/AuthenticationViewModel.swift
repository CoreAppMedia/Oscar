//
//  AuthenticationViewModel.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 20/10/23.
//
import Foundation
import FirebaseAuth

final class AuthenticationViewModel: ObservableObject{
    
    @Published var user: User?
    @Published var messageError: String?
    
    private let authenticationRepository: AuthenticationRepository
    
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getcurrentUser()
    }
    
    func getcurrentUser(){
        self.user = authenticationRepository.getCurrentUser()
    }
     
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                // Usuario creado exitosamente
                self?.user = user
                self?.sendEmailVerification()
            case .failure(let error):
                // Error durante la creación del usuario
                self?.messageError = error.localizedDescription
            }
        }
    }
    private func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { [weak self] error in
            if let error = error {
                print("Error al enviar el correo de verificación: \(error.localizedDescription)")
                // Maneja el error según tus necesidades
            } else {
                print("Correo de verificación enviado exitosamente.")
                // Realiza acciones adicionales si es necesario
            }
        })
    }
    
    
    func login(email: String, password: String){
        authenticationRepository.login(email: email, password: password){[weak self] result in
            
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
        
            }
            
        }
    }
    
    func logout(){
        do{
            try authenticationRepository.logout()
            self.user = nil
        }catch{
            print("Error logout Master")
        }
    }
    
    func resetPassword(forEmail email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
