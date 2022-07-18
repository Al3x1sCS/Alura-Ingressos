//
//  LocalizacaoConsultaAPI.swift
//  Alura Ingressos
//
//  Created by user on 18/07/22.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {
    
    func consultaCepAPI(cep: String, sucesso: @escaping(_ localizacao: Localizacao) -> Void, falha: @escaping(_ erro: Error) -> Void) {
        
        Alamofire.request("https://viacep.com.br/ws/\(cep)/json/", method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let resultado = response.result.value as? Dictionary<String, String> {
                    let localizacao = Localizacao(resultado)
                    sucesso(localizacao)
                }
                break
            case .failure:
                falha(response.result.error!)
                break
            }
        }
        
    }
    
}
