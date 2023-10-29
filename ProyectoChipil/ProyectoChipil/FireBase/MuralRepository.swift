//
//  MuralRepository.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 25/10/23.
//

import Foundation


//inicializamos los datos que nos mandan desde LinkData para poder hacer la coneccion con el View model, es como el puente de coneccion
final class LinkRepository {
    private let linkDatasource: LinkDatasource
    
    init(linkDatasource: LinkDatasource = LinkDatasource() ){
        self.linkDatasource = linkDatasource
    }
    
    //con este metodo conseguimos los datos que estan en la base de datos, los cuales mandaremos a la view
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        linkDatasource.getAlllinks(completionBlock: completionBlock)
        }
    
    
    
        //modulo para agragar datos a la base de datos, Esto es un experiemnto asi que puede que no funcione jeje
    func createNew(like: Bool, noticia: String,titulo: String,fecha: Date, completionBlock:@escaping (Result<LinkModel, Error>) -> Void){
            linkDatasource.createNew(Datos: LinkModel(like: true, 
                                                      noticia: noticia,
                                                      titulo: titulo, 
                                                      fecha: fecha),
                                                        completionBlock: completionBlock)
        }
    //esta funcion nos permite crear una nueva tabla para cada usuario
    func crearTabla(nombre: String, apellidoP: String, apellidoM: String,descripcion:String,titulo: String,numeroTel: String,textFieldEmail: String){
        linkDatasource.crearTabla(nombre: nombre,
                                  apellidoP: apellidoP,
                                  apellidoM: apellidoM,
                                  descripcion: descripcion,
                                  titulo: titulo,
                                  numeroTel: numeroTel,
                                  textFieldEmail: textFieldEmail)
        }
    
    func update(link: LinkModel){
        linkDatasource.update(link: link)
    }
    
    
    func delete(link: LinkModel){
        linkDatasource.delete(link: link)
    }
    
}
