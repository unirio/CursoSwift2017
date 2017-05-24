//
//  Modelo.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 16/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

class ListaMercado {
	var items : [Item] = []
	var secoes : [Secao] = []
	
	// Retorna uma secao, dado seu nome
	func pegaSecaoNome(nome: String) -> Secao? {
		return secoes.filter({ $0.nome == nome }).first
	}
	
	// Retorna o indice de uma secao
	func pegaIndiceSecao(secao: Secao) -> Int? {
		return secoes.index(where: { $0.nome == secao.nome })
	}
}
