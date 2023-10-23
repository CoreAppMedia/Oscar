//
//  EstructurasCuestionarios.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 23/10/23.
//
import SwiftUI


//Modelo de la informacion de los ciestionarios
struct Informacion: Codable{
    var title: String
    var peopleAttended: Int
    var rules:[String]
    
    enum CodingKeys: CodingKey {
        case title
        case peopleAttended
        case rules
    }
}

//modelo para las preguntas del cuestionario
struct Preguntas: Identifiable, Codable{
    var id: UUID = .init()
    var question: String
    var options: [String]
    var answer: String
    
    //respuesta del tappend, para las actualizaciones de estado de la interfaz
    var tappedanswer: String = ""
    
    enum CodingKeys: CodingKey{
        case question
        case options
        case answer
        
    }
}
