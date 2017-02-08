//
//  TemperaturaCalculator.swift
//  Conversor
//
//  Created by Marcio Barros on 03/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

public class TemperaturaCalculator {
	
	private var temperaturaKelvin = 0.0
	
	public var Celsius : Double {
		get {
			return temperaturaKelvin - 273.15
		}
		set {
			temperaturaKelvin = newValue + 273.15
		}
	}
	
	public var Fahrenheit : Double {
		get {
			return temperaturaKelvin * 9.0 / 5.0 - 459.67
		}
		set {
			temperaturaKelvin = (newValue + 459.67) * 5.0 / 9.0
		}
	}
	
	public var Kelvin : Double {
		get {
			return temperaturaKelvin
		}
		set {
			temperaturaKelvin = newValue
		}
	}
}
