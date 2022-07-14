//
//  ValidaFormulario.swift
//  Alura Ingressos
//
//  Created by user on 14/07/22.
//

import UIKit

enum TiposDeTextField:Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroDoCartao = 7
    case mesDeVencimento = 8
    case anoDeVencimento = 9
    case codigoDeSeguranca = 10
    case parcela = 11
}

class ValidaFormulario: NSObject {
    
    func verificaTextFieldsPreenchidos(textFields: Array<UITextField>) -> Bool {
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        return true
        
    }
    
    func exibeNotificacaoDePreenchimentoDosTextFields(titulo: String, mensagem: String) -> UIAlertController {
        let notificacao = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        notificacao.addAction(botao)
        
        return notificacao
    }

}
