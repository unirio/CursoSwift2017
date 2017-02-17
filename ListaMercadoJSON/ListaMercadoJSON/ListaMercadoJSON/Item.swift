//
//  Item.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 17/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

class Item {
	var nome = ""
	var quantidade = 0
	var secao : Secao
	
	init(nome: String, quantidade: Int, secao: Secao) {
		self.nome = nome
		self.quantidade = quantidade
		self.secao = secao
	}
}
