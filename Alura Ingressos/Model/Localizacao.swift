//
//  Localizacao.swift
//  Alura Ingressos
//
//  Created by user on 18/07/22.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario:Dictionary<String, String>) {
        logradouro = dicionario["logradouro"] ?? ""
        bairro = dicionario["bairro"] ?? ""
        cidade = dicionario["localidade"] ?? ""
        uf = dicionario["uf"] ?? ""
    }
    
}
