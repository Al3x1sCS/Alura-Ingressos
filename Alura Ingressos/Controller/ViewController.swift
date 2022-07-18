//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by user on 13/07/22.
//

import UIKit

class ViewController: UIViewController, PickerViewMesSelecionado, PickerViewAnoSelecionado, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

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
    
    @objc func aumentarScrollView(notification: Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + 870)
    }
    
    // MARK: - PickerViewDelegate
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { textFieldMes in
            textFieldMes.text = mes
        }
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento) { textFieldAno in
            textFieldAno.text = ano
        }
    }
    
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            present(ValidaFormulario().exibeNotificacaoDeCompraRealizada(), animated: true, completion: nil)
            //let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Parabéns", mensagem: "Compra efetuada com sucesso.") // <- Estas linhas não deveriam estar no ViewController
            //present(alerta, animated: true, completion: nil)
        }
        else {
            present(ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(), animated: true, completion: nil)
            //let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Alerta!", mensagem: "Preencha todos os campos corretamente.") // <- Estas linhas não deveriam estar no ViewController
            //present(alerta, animated: true, completion: nil)
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
    
    
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
        
    }
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldCodigoDeSeguranca(_ sender: UITextField) {
        
        guard let texto = sender.text else { return }
        
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { textFieldCodigoSeguranca in
                textFieldCodigoSeguranca.text = String(codigo)
            }
        }
        else {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { textFieldCodigoSeguranca in
                textFieldCodigoSeguranca.text = texto
            }
        }
        
    }
    
}

