//
//  ValidaFormulario.swift
//  Alura Ingressos
//
//  Created by user on 14/07/22.
//

import UIKit

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
