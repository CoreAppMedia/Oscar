//
//  Model.swift
//  ImagenesGPT4
//
//  Created by Oscar Valdes on 15/11/23.
//

import Foundation

struct DataReponse: Decodable{
    let url: String
}

struct ModelResponse: Decodable{
    let data: [DataReponse]
}
