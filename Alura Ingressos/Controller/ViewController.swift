//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by user on 13/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buscaTextField(tipoDeTextField: TiposDeTextField, completion: (_ textFieldSolicitado: UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TiposDeTextField(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Parabéns", mensagem: "Compra efetuada com sucesso.")
            present(alerta, animated: true, completion: nil)
        }
        else {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Alerta!", mensagem: "Preencha todos os campos corretamente.")
            present(alerta, animated: true, completion: nil)
        }
    }
    
    @IBAction func TextFieldCEPAlterouValor(_ sender: UITextField) {
        
        LocalizacaoConsultaAPI().consultaCepAPI(cep: sender.text!) { localizacao in
            self.buscaTextField(tipoDeTextField: .endereco) { textFieldEndereco in
                textFieldEndereco.text = localizacao.logradouro
            }
            self.buscaTextField(tipoDeTextField: .bairro) { textFieldBairro in
                textFieldBairro.text = localizacao.bairro
            }
        } falha: { error in
            print(error)
        }


        
    }
    
    
}

