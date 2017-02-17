//
//  ViewController.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 16/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit

// http://www.learncoredata.com/icloud-key-value-store/

// http://www.learncoredata.com/nsfetchedresultscontroller-swift/

// http://www.learncoredata.com/how-to-save-files-part-1/

// http://www.learncoredata.com/how-to-save-files-part-2/

// http://www.learncoredata.com/how-to-use-nsuserdefaults/

class ViewController: UITableViewController {

	// Modelo da aplicacao
	private var modelo = Modelo()

	// Carrega as secoes e itens antes de abrir a tela
	override func viewDidLoad() {
		let fileManager = FileHelper(fileName: "modelo.json")
		let jsonModelo = fileManager.loadJson()
		ImportadorModelo().fromJson(json: jsonModelo, modelo: modelo)
		
		if modelo.secoes.count == 0 {
			modelo.secoes.append(Secao(nome: "Laticinios"));
			modelo.secoes.append(Secao(nome: "Carnes e Aves"));
			modelo.secoes.append(Secao(nome: "Cereais e Farinhas"));
			modelo.secoes.append(Secao(nome: "Bebidas"));
			modelo.secoes.append(Secao(nome: "Enlatados"));
			modelo.secoes.append(Secao(nome: "Limpeza"));
			modelo.secoes.append(Secao(nome: "Higiene"));
			modelo.secoes.append(Secao(nome: "Frutas e Verduras"));
		}
	}

	// Carrega as secoes e itens antes de abrir a tela
	override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}
	
	// Programa o numero de secoes da tabela
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}

	// Programa o numero de linhas da tabela
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return modelo.items.count
	}
	
	// Programa uma celula da tabela
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "celula")!
		cell.textLabel?.text = modelo.items[indexPath.row].nome
		cell.detailTextLabel?.text = modelo.items[indexPath.row].secao.nome
		return cell
	}
	
	// Indica que as linhas da tabela sao editaveis
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	// Indica as acoes de edicao de uma linha da tabela
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let editRowAction = UITableViewRowAction(style: .normal, title: " Edit ", handler: handleEdition)
		let deleteRowAction = UITableViewRowAction(style: .default, title: "Delete", handler: handleDeletion)
		return [editRowAction, deleteRowAction]
	}

	// Abre a tela para criar um novo item
	@IBAction func addItem(_ sender: Any) {
		let formController = self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
		formController.modelo = modelo
		navigationController?.pushViewController(formController, animated: true)
	}
	
	// Abre a tela para editar um item
	func handleEdition(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
		tableView.isEditing = false
		let formController = self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
		formController.modelo = modelo
		formController.item = modelo.items[indexPath.row]
		navigationController?.pushViewController(formController, animated: true)
	}
	
	// Remove um item
	func handleDeletion(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
		tableView.isEditing = false
		modelo.items.remove(at: indexPath.row)
		let fileManager = FileHelper(fileName: "modelo.json")
		fileManager.save(json: ExportadorModelo().toJson(modelo: modelo))
		tableView.reloadData()
	}
}
