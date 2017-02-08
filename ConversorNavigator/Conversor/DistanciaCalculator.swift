//
//  DistanciaCalculator.swift
//  Conversor
//
//  Created by Marcio Barros on 03/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

open class DistanciaCalculator {
	
	fileprivate var distanciaMilimetros = 0.0
	
	open var Metros : Double {
		get {
			return distanciaMilimetros / 1000.0
		}
		set {
			distanciaMilimetros = newValue * 1000.0
		}
	}
	
	open var Centimetros : Double {
		get {
			return distanciaMilimetros / 10.0
		}
		set {
			distanciaMilimetros = newValue * 10.0
		}
	}
	
	open var Milimetros : Double {
		get {
			return distanciaMilimetros
		}
		set {
			distanciaMilimetros = newValue
		}
	}
}
