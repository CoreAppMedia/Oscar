//
//  muralViewModel.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 25/10/23.
//
import Foundation
//hacemos la coneccion entre la  el View model y el repositorio para posterirmente mandar esa informacion a la base de datos por medio del Datasource
final class LinkViewModel: ObservableObject {
    
    @Published var links: [LinkModel] = []
    @Published var messageError: String?
    
    private let linkRepository: LinkRepository
    
    init(linkRepository: LinkRepository = LinkRepository()){
    
        self.linkRepository = linkRepository
    }
    
    //obtenemos los datos del repositorio que contiene los datos provenientes de la base de datos
    func getAllLink(){
        linkRepository.getAllLinks { [weak self]result in
            switch result{
            case.success(let linkModels):
                self?.links = linkModels
                
            case.failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    //modulo para agragar datos a la base de datos, Esto es un experiemnto asi que puede que no funcione jeje
    func createNewUser(like: Bool, noticia: String,titulo: String,fecha: Date){
        linkRepository.createNew(like: true,
                                 noticia: noticia,
                                 titulo: titulo,
                                 fecha: fecha){ [weak self] result in
            switch result{
            case .success(_):
                //solo se manda un mensaje pues ladots se colocaran directamente de la base de datos
                print("nueva noticia optenida")
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    func crearTabla(nombre: String, apellidoP: String, apellidoM: String,descripcion:String,titulo: String,numeroTel: String,textFieldEmail: String){
        linkRepository.crearTabla(nombre: nombre,
                                  apellidoP: apellidoP,
                                  apellidoM: apellidoM,
                                  descripcion: descripcion,
                                  titulo: titulo,
                                  numeroTel: numeroTel,
                                  textFieldEmail: textFieldEmail)
        print("Tabla guardada exitosamente")
        
    }
    func updateIsFavorited(link: LinkModel){
        let updateLink = LinkModel(id: link.id,
                                   like: link.like ? false: true,
                                   noticia: link.noticia,
                                   titulo: link.titulo ,
                                   fecha: link.fecha)
        
        linkRepository.update(link: updateLink)
    }
    
    func delete(link: LinkModel){
        linkRepository.delete(link: link)
    }
    
}
