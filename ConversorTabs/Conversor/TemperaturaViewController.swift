//
//  TemperaturaViewController.swift
//  Conversor
//
//  Created by Marcio Barros on 03/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit

class TemperaturaViewController: UIViewController {

	private let calculador = TemperaturaCalculator()

	@IBOutlet weak var txtCelsius: UITextField!

	@IBOutlet weak var txtFahrenheit: UITextField!

	@IBOutlet weak var txtKelvin: UITextField!
	
	@IBAction func editedCelsius(_ sender: UITextField) {
		if let temperatura = Double(sender.text!) {
			calculador.Celsius = temperatura
			txtFahrenheit!.text = String(calculador.Fahrenheit)
			txtKelvin!.text = String(calculador.Kelvin)
		}
		else {
			txtFahrenheit!.text = ""
			txtKelvin!.text = ""
		}
	}
	
	@IBAction func editedFahrenheit(_ sender: UITextField) {
		if let temperatura = Double(sender.text!) {
			calculador.Fahrenheit = temperatura
			txtCelsius!.text = String(calculador.Celsius)
			txtKelvin!.text = String(calculador.Kelvin)
		}
		else {
			txtCelsius!.text = ""
			txtKelvin!.text = ""
		}
	}
	
	@IBAction func editKelvin(_ sender: UITextField) {
		if let temperatura = Double(sender.text!) {
			calculador.Kelvin = temperatura
			txtCelsius!.text = String(calculador.Celsius)
			txtFahrenheit!.text = String(calculador.Fahrenheit)
		}
		else {
			txtCelsius!.text = ""
			txtFahrenheit!.text = ""
		}
	}
}
