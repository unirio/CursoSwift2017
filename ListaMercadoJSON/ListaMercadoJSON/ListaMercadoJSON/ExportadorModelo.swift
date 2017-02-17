//
//  ExportadorModelo.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 17/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

class ExportadorModelo {
	
	// Exporta o modelo para JSON
	func toJson(modelo: Modelo) -> JSONObject {
		var jsonSecoes = JSONArray()
		
		for secao in modelo.secoes {
			jsonSecoes.append(toJson(secao: secao))
		}
		
		var jsonItems = JSONArray()
		
		for item in modelo.items {
			jsonItems.append(toJson(item: item))
		}
		
		var resultado = JSONObject()
		resultado["secoes"] = jsonSecoes
		resultado["items"] = jsonItems
		return resultado
	}
	
	// Exporta uma secao para JSON
	private func toJson(secao: Secao) -> JSONObject {
		var resultado = JSONObject()
		resultado["nome"] = secao.nome
		return resultado
	}

	// Exporta um item para JSON
	private func toJson(item: Item) -> JSONObject {
		var resultado = JSONObject()
		resultado["nome"] = item.nome
		resultado["qtde"] = item.quantidade
		resultado["secao"] = item.secao.nome
		return resultado
	}
}
