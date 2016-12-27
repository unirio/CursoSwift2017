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
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
		case Equals
	}
	
	private var operacoes : Dictionary<String,TipoOperacao> =
	[
		"π"  : .Constant(M_PI),
		"e"  : .Constant(M_E),
		"R"  : .UnaryOperation(sqrt),
		"cos": .UnaryOperation(cos),
		"+"  : .BinaryOperation(soma),
		"-"  : .BinaryOperation(subtracao),
		"/"  : .BinaryOperation(divisao),
		"*"  : .BinaryOperation(produto),
		"="  : .Equals
	]
	
	func setOperando(operando: Double) {
		self.acumulador = operando
	}
	
	func executaOperacao(simbolo: String) {
		if let operacao	= operacoes[simbolo] {
			switch operacao {
			case .Constant(let value):
				acumulador = value

			case .UnaryOperation(let function):
				acumulador = function(acumulador)

			case .BinaryOperation(let function):
				executaOperacaoBinariaPendente()
				pendencia = DadosOperacaoBinariaPendente(operador: function, operando: acumulador)
				
			case .Equals:
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

