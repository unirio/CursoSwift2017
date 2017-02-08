//
//  Calculadora.swift
//  Calculadora
//
//  Created by Marcio Barros on 22/12/16.
//  Copyright © 2016 UNIRIO. All rights reserved.
//

import Foundation

class Calculadora {
	
	private var acumulador = 0.0
	
	private enum TipoOperacao {
		case constant(Double)
		case unaryOperation((Double) -> Double)
		case binaryOperation((Double, Double) -> Double)
		case equals
	}
	
	private var operacoes : Dictionary<String,TipoOperacao> =
	[
		"π"  : .constant(M_PI),
		"e"  : .constant(M_E),
		"R"  : .unaryOperation(sqrt),
		"cos": .unaryOperation(cos),
		"+"  : .binaryOperation(soma),
		"-"  : .binaryOperation(subtracao),
		"/"  : .binaryOperation(divisao),
		"*"  : .binaryOperation(produto),
		"="  : .equals
	]
	
	func setOperando(_ operando: Double) {
		self.acumulador = operando
	}
	
	func executaOperacao(_ simbolo: String) {
		if let operacao	= operacoes[simbolo] {
			switch operacao {
			case .constant(let value):
				acumulador = value

			case .unaryOperation(let function):
				acumulador = function(acumulador)

			case .binaryOperation(let function):
				executaOperacaoBinariaPendente()
				pendencia = DadosOperacaoBinariaPendente(operador: function, operando: acumulador)
				
			case .equals:
				executaOperacaoBinariaPendente()
			}
		}
	}
	
	private func executaOperacaoBinariaPendente() {
		if pendencia != nil {
			acumulador = pendencia!.operador(pendencia!.operando, acumulador)
			pendencia = nil
		}
	}
	
	private var pendencia : DadosOperacaoBinariaPendente?
	
	private struct DadosOperacaoBinariaPendente {
		var operador : (Double, Double) -> Double
		var operando : Double
	}
	
	var result : Double {
		get {
			return acumulador;
		}
	}
}

private let soma: (Double, Double) -> Double = (+)

private let subtracao: (Double, Double) -> Double = (-)

private let produto: (Double, Double) -> Double = (*)

private let divisao: (Double, Double) -> Double = (/)

