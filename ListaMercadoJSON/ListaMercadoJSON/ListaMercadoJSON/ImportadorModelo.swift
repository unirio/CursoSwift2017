//
//  ImportadorModelo.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 17/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

class ImportadorModelo {
	
	// Carrega um modelo a partir da sua representacoa JSON
	func fromJson(json: JSONObject, modelo: Modelo) {
		if let jsonSecoes = json["secoes"] as? JSONArray {
			for jsonSecao in jsonSecoes {
				if let secao = secaoFromJson(json: jsonSecao as! JSONObject) {
					modelo.secoes.append(secao)
				}
			}
		}
		
		if let jsonItems = json["items"] as? JSONArray {
			for jsonItem in jsonItems {
				if let item = itemFromJson(json: jsonItem as! JSONObject, modelo: modelo) {
					modelo.items.append(item)
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
	private func itemFromJson(json: JSONObject, modelo: Modelo) -> Item? {
		if let nome = json["nome"] as? String, let quantidade = json["qtde"] as? Int, let nomeSecao = json["secao"] as? String {
			if let secao = modelo.pegaSecaoNome(nome: nomeSecao) {
				return Item(nome: nome, quantidade: quantidade, secao: secao)
			}
		}
		
		return nil
	}
}
