//
//  ViewController.swift
//  Calculadora
//
//  Created by Marcio Barros on 15/12/16.
//  Copyright © 2016 UNIRIO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet private weak var visor: UILabel!
	
	private var usuarioDigitando = false
	
	private var calculadora = Calculadora()
	
	@IBAction func touchDigit(_ sender: UIButton) {
		let digito = sender.currentTitle!
		
		if self.usuarioDigitando {
			let textoAtual = visor.text!
			visor.text = textoAtual + digito
		}
		else {
			visor.text = digito
		}
		
		self.usuarioDigitando = true
	}
	
	var displayValue : Double {
		get {
			return Double(visor.text!)!
		}
		set {
			visor.text = String(newValue)
		}
	}
	
	@IBAction func performOperation(_ sender: UIButton) {
		if usuarioDigitando {
			calculadora.setOperando(displayValue)
			usuarioDigitando = false
		}
		
		if let mathSymbol = sender.currentTitle {
			calculadora.executaOperacao(mathSymbol)
			displayValue = calculadora.result
		}
	}
}
