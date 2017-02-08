//
//  ViewController.swift
//  listamercado
//
//  Created by Marcio Barros on 01/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

	// Secoes do banco de dados
	private var secoes : [Secao] = []

	// Itens do banco de dados
	private var items : [Item] = []

	// Carrega as secoes e itens antes de abrir a tela
	override func viewWillAppear(_ animated: Bool) {
		secoes = SecaoDAO.instance.carregaTodasSecoes()
		
		if secoes.isEmpty {
			SecaoDAO.instance.criaSecoes()
			secoes = SecaoDAO.instance.carregaTodasSecoes()
		}

		items = ItemDAO.instance.carregaItems()
		tableView.reloadData()
	}
	
	// Programa o numero de secoes da tabela
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}

	// Programa o numero de linhas da tabela
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	// Programa uma celula da tabela
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
		cell.textLabel?.text = items[indexPath.row].nome
		cell.detailTextLabel?.text = items[indexPath.row].secao?.nome
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
	@IBAction func addItemClick(_ sender: Any) {
		let formController = self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
		formController.secoes = secoes
		navigationController?.pushViewController(formController, animated: true)
	}
	
	// Abre a tela para editar um item
	func handleEdition(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
		tableView.isEditing = false
		let item = items[indexPath.row]
		let formController = self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
		formController.secoes = secoes
		formController.item = item
		navigationController?.pushViewController(formController, animated: true)
	}
	
	// Remove um item
	func handleDeletion(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
		tableView.isEditing = false
		let item = items[indexPath.row]
		ItemDAO.instance.removeItem(item: item)
		items = ItemDAO.instance.carregaItems()
		tableView.reloadData()
	}
}
