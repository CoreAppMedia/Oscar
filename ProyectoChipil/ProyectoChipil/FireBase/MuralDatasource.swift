//
//  MuralDatasource.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 25/10/23.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


// esta estructura nos ayuda a almacenar los tados para posterirmente mandarlos a la base de datos
struct LinkModel: Decodable, Identifiable, Encodable{
    @DocumentID var id: String?
    let like: Bool
    let noticia: String
    let titulo: String
    let fecha: Date
    
    
}

final class LinkDatasource {
    
    private let database = Firestore.firestore()
    private let collection = "Mural"
    
    
    //con este metodo se hace la coneccion ente los datos y la base de datos para posterimente usarlo en el repositorio o en la View
    
    func getAlllinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        database.collection(collection)
            .addSnapshotListener{ query, error in
                if let error = error{
                    print("Error al conseguir el link \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                
                guard let documents = query?.documents.compactMap({ $0}) else{
                    completionBlock(.success([]))
                    return
                }
                
                let links = documents.map {try? $0.data(as: LinkModel.self)}
                    .compactMap{ $0 }
                completionBlock(.success(links))
                
            }
    }
    
            //modulo para agragar datos a la base de datos, Esto es un experiemnto asi que puede que no funcione jeje
            func createNew(Datos: LinkModel, completionBlock:@escaping (Result<LinkModel, Error>) -> Void){
                do{
                    
                    _ = try database.collection(collection).addDocument(from: Datos)
                    completionBlock(.success(Datos))
                }catch{
                    completionBlock(.failure(error))
                }
            }
    //Con este metodo Actualizamos la Informacion de un registro ya existente.
    func update(link: LinkModel){
        guard let documentId = link.id else{
            return
        }
        do{
            _ = try database.collection(collection).document(documentId).setData(from: link)
        } catch {
            print("Error de Actualizacion en la Base de Datos")
        }
    }
    
    ////Con este metodo Eliminamos la Informacion de un registro ya existente.
    func delete(link: LinkModel){
        guard let documentId = link.id else{
            return
        }
        database.collection(collection).document(documentId).delete()
    }
    //esta funcion nos permite crear una nueva tabla para cada usuario
    func crearTabla(nombre: String, apellidoP: String, apellidoM: String,descripcion:String,titulo: String,numeroTel: String,textFieldEmail: String){
        Firestore.firestore().collection("Usuarios").document(textFieldEmail).setData([
            "nombre": nombre ,
            "apellidoP": apellidoP,
            "apellidoM": apellidoM,
            "descripcion": descripcion,
            "titulo": titulo,
            "numeroTel": numeroTel,
            "correoElectronico": textFieldEmail]) { error in
            if let error = error {
                print("Error al agregar el documento \(textFieldEmail): \(error.localizedDescription)")
            } else {
                print("Documento \(textFieldEmail) agregado con éxito")
            }
        }
        
    }
    
}
