//
//  ValidaFormulario.swift
//  Alura Ingressos
//
//  Created by user on 14/07/22.
//

import UIKit
import CPF_CNPJ_Validator

enum TiposDeTextField: Int {
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
        var textFieldsEstaoPreenchidos = true
        
        for textField in textFields {
            if textField.text == "" {
                textFieldsEstaoPreenchidos = false
                // return false
            } else {
                textFieldsEstaoPreenchidos = true
            }
        }
        return textFieldsEstaoPreenchidos
        // return true
    }
    
    func verificaTextFieldsValidos(listaDeTextFields:Array<UITextField>) -> Bool {
        var dicionarioDeTextFields:Dictionary<TiposDeTextField, UITextField> = [:]

        for textField in listaDeTextFields {
            if let tiposTextField = TiposDeTextField(rawValue: textField.tag) {
                dicionarioDeTextFields[tiposTextField] = textField
            }
        }
        
        guard let cpf = dicionarioDeTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!)  else { return false }
        guard let email = dicionarioDeTextFields[.email], self.verificaEmail(email.text!) else { return false }
        
        return true
    }
    
    func verificaEmail(_ email:String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)

        return emailTest.evaluate(with: email)
    }
    
    func exibeNotificacaoDePreenchimentoDosTextFields() -> UIAlertController {
        let notificacao = UIAlertController(title: "Atenção", message: "Preencha corretamente os campos", preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        notificacao.addAction(botao)

        return notificacao
    }
    
    func exibeNotificacaoDeCompraRealizada() -> UIAlertController {
            let notificacao = UIAlertController(title: "Parabens", message: "Compra realizada com sucesso", preferredStyle: .alert)
            let botao = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            notificacao.addAction(botao)
            
            return notificacao
        }

}
