//
//  FormViewController.swift
//  listamercado
//
//  Created by Marcio Barros on 02/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	
	var item : Item?
	
	var secoes : [Secao]?

	@IBOutlet weak var editNome: UITextField!
	
	@IBOutlet weak var editSecao: UITextField!
	
	@IBOutlet weak var editQuantidade: UITextField!
	
	@IBOutlet weak var pickerSecao: UIPickerView!
	
	// Apresenta o item selecionado quando abrir a tela
	override func viewDidLoad() {
		super.viewDidLoad()
		self.pickerSecao.delegate = self
		self.pickerSecao.dataSource = self
		self.editSecao.delegate = self

		if let oItem = item {
			editNome.text = oItem.nome
			editSecao.text = oItem.secao?.nome
			editQuantidade.text = "\(oItem.quantidade!)"
			
			if let secao = oItem.secao {
				if let row = secoes!.index(of: secao) {
					pickerSecao.selectRow(row, inComponent: 0, animated: true)
				}
			}
		}
	}

	// Programa o numero de colunas na combo
	func numberOfComponents(in: UIPickerView) -> Int {
		return 1
	}
	
	// Programa o numero de linhas na combo
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return secoes!.count
	}
	
	// Pega a informacao de uma linha da combo
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return secoes![row].nome
	}
	
	// Preenche a linha de edicao quando seleciona uma secao
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		editSecao.text = secoes![row].nome
	}
	
	// Apresenta a combo quando seleciona a linha de secao
	@IBAction func textSecaoTouch(_ sender: Any) {
		pickerSecao.isHidden = false
	}
	
	// Esconde a combo quando sai da linha de secao
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		pickerSecao.isHidden = true
		return true
	}
	
	// Impede a digitacao na linha de secao
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return false
	}
	
	// Pega a secao selecionada
	func pegaSecaoSelecionada() -> Secao? {
		return secoes?.filter({$0.nome == editSecao.text!}).first
	}
	
	// Apresenta uma mensagem de erro
	func apresentaErro(mensagem: String) {
		let alert = UIAlertController(title: "Erro", message: mensagem, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	// Cria ou atualiza um item
	@IBAction func saveButtonClicked(_ sender: Any) {
		let nome = editNome.text
		let quantidade = Int(editQuantidade.text!)
		let secao = pegaSecaoSelecionada()
		
		if nome == nil || nome!.isEmpty {
			apresentaErro(mensagem: "A quantidade não pode ser menor ou igual a zero.")
			return
		}
		
		if quantidade == nil || quantidade! <= 0 {
			apresentaErro(mensagem: "A quantidade não pode ser menor ou igual a zero.")
			return
		}
		
		if secao == nil {
			apresentaErro(mensagem: "A quantidade não pode ser menor ou igual a zero.")
			return
		}
		
		if let oItem = item {
			ItemDAO.instance.atualizaItem(item: oItem, nome: nome!, quantidade: quantidade!, secao: secao!)
		}
		else {
			ItemDAO.instance.criaItem(nome: nome!, quantidade: quantidade!, secao: secao!)
		}
		
		_ = navigationController?.popViewController(animated: true)
	}
}
