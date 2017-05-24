//
//  ImportadorListaMercado.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 17/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

class ImportadorListaMercado {
	
	// Carrega um modelo a partir da sua representacoa JSON
	func fromJson(json: JSONObject, lista: ListaMercado) {
		if let jsonSecoes = json["secoes"] as? JSONArray {
			for jsonSecao in jsonSecoes {
				if let secao = secaoFromJson(json: jsonSecao as! JSONObject) {
					lista.secoes.append(secao)
				}
			}
		}
		
		if let jsonItems = json["items"] as? JSONArray {
			for jsonItem in jsonItems {
				if let item = itemFromJson(json: jsonItem as! JSONObject, lista: lista) {
					lista.items.append(item)
				}
			}
		}
	}
	
	// Carrega uma secao a partir da sua representacao JSON
	private func secaoFromJson(json: JSONObject) -> Secao? {
		if let nome = json["nome"] as? String {
			return Secao(nome: nome)
		}
		
		return nil
	}
	
	// Carrega um item a partir da sua representacao JSON
	private func itemFromJson(json: JSONObject, lista: ListaMercado) -> Item? {
		if let nome = json["nome"] as? String, let quantidade = json["qtde"] as? Int, let nomeSecao = json["secao"] as? String {
			if let secao = lista.pegaSecaoNome(nome: nomeSecao) {
				return Item(nome: nome, quantidade: quantidade, secao: secao)
			}
		}
		
		return nil
	}
}
