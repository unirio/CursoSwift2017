//
//  CountryIdentifier.swift
//  Paises
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

public class CountryIdentifier {
	public var Code = ""
	public var Name = ""
	
	//
	// Inicializa o identificador de país com todos os seus dados
	//
	convenience init(code: String, name: String) {
		self.init()
		self.Code = code
		self.Name = name
	}
}