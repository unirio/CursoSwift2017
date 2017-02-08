//
//  SecaoDAO.swift
//  listamercado
//
//  Created by Marcio Barros on 07/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import CoreData

class SecaoDAO {

	// Instancia unica do DAO
	static let instance = SecaoDAO()

	// Construtor privativo
    private init() {
    }

	// Acesso ao contexto de persistência criado pela aplicação
	private func getContext() -> NSManagedObjectContext {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		return appDelegate.managedObjectContext
	}
	
	// Carrega uma secao, dado seu nome
	func carregaSecao(nome: String) -> Secao? {
		let context = getContext()
		let request = NSFetchRequest<Secao>(entityName: "Secao")
		request.predicate = NSPredicate(format: "nome == %@", nome)

		do {
			return try context.fetch(request)[0]
		}
		catch {
			print("Erro ao carregar uma secao: \(error)")
			return nil
		}
	}
	
	// Carrega as secoes
	func carregaTodasSecoes() -> [Secao] {
		let context = getContext()
		let request = NSFetchRequest<Secao>(entityName: "Secao")
		request.fetchBatchSize = 100
		request.fetchLimit = 100

		do {
			return try context.fetch(request)
		}
		catch {
			print("Erro ao carregar todas as secoes: \(error)")
			return []
		}
	}
	
	// Cria os registros das secoes
	func criaSecoes() {
		criaSecao(nome: "Laticinios")
		criaSecao(nome: "Carnes e Aves")
		criaSecao(nome: "Cereais e Farinhas")
		criaSecao(nome: "Bebidas")
		criaSecao(nome: "Enlatados")
		criaSecao(nome: "Limpeza")
		criaSecao(nome: "Higiene")
		criaSecao(nome: "Frutas e Verduras")
	}

	// Cria o registro de uma secao
	func criaSecao(nome: String) {
		let context = getContext()

		if let secao = NSEntityDescription.insertNewObject(forEntityName: "Secao", into: context) as? Secao {
			secao.nome = nome
		}

		do {
			try context.save()
		}
		catch {
			print("Erro ao criar uma secao: \(error)")
		}
	}
}
