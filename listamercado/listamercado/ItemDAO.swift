//
//  CoreDataManager.swift
//  listamercado
//
//  Created by Marcio Barros on 01/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import CoreData

class ItemDAO {

	// Instancia unica do DAO
	static let instance = ItemDAO()

	// Construtor privativo
    private init() {
    }

	// Acesso ao contexto de persistência criado pela aplicação
	private func getContext() -> NSManagedObjectContext {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		return appDelegate.managedObjectContext
	}
	
	// Carrega todos os items registrados
	func carregaItems() -> [Item] {
		let context = getContext()
		let request : NSFetchRequest<Item> = Item.fetchRequest()
		request.fetchBatchSize = 1000
		request.fetchLimit = 1000

		do {
			return try context.fetch(request)
		}
		catch {
			print("Erro ao carregar os itens: \(error)")
			return []
		}
	}

	// Cria um novo item
	func criaItem(nome: String, quantidade: Int, secao: Secao) {
		let context = getContext()

		if let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item {
			item.nome = nome
			item.quantidade = NSNumber(value: quantidade)
			item.comprado = false
			item.secao = secao
		}

		do {
			try context.save()
		}
		catch {
			print("Erro ao criar um item: \(error)")
		}
	}

	// Atualiza um item
	func atualizaItem(item: Item, nome: String, quantidade: Int, secao: Secao) {
		let context = getContext()
		item.nome = nome
		item.quantidade = NSNumber(value: quantidade)
		item.comprado = false
		item.secao = secao
		
		do {
			try context.save()
		}
		catch {
			print("Erro ao atualizar um item: \(error)")
		}
	}

	// Remove um item
	func removeItem(item: Item) {
		let context = getContext()
		context.delete(item)
		
		do {
			try context.save()
		}
		catch {
			print("Erro ao remover um item: \(error)")
		}
	}
}
