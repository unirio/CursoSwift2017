//
//  DistanciaViewController.swift
//  Conversor
//
//  Created by Marcio Barros on 03/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit

class DistanciaViewController: UIViewController {

	private let calculador = DistanciaCalculator()

	@IBOutlet weak var txtMetros: UITextField!

	@IBOutlet weak var txtCentimetros: UITextField!

	@IBOutlet weak var txtMilimetros: UITextField!

	@IBAction func editedMetros(sender: UITextField) {
		if let distancia = Double(sender.text!) {
			calculador.Metros = distancia
			txtCentimetros!.text = String(calculador.Centimetros)
			txtMilimetros!.text = String(calculador.Milimetros)
		}
	}


	@IBAction func editedCentimetros(sender: UITextField) {
		if let distancia = Double(sender.text!) {
			calculador.Centimetros = distancia
			txtMetros!.text = String(calculador.Metros)
			txtMilimetros!.text = String(calculador.Milimetros)
		}
	}

	@IBAction func editedMilimetros(sender: UITextField) {
		if let distancia = Double(sender.text!) {
			calculador.Milimetros = distancia
			txtMetros!.text = String(calculador.Metros)
			txtCentimetros!.text = String(calculador.Centimetros)
		}
	}
}
