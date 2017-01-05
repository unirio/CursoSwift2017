//
//  DistanciaCalculator.swift
//  Conversor
//
//  Created by Marcio Barros on 03/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

public class DistanciaCalculator {
	
	private var distanciaMilimetros = 0.0
	
	public var Metros : Double {
		get {
			return distanciaMilimetros / 1000.0
		}
		set {
			distanciaMilimetros = newValue * 1000.0
		}
	}
	
	public var Centimetros : Double {
		get {
			return distanciaMilimetros / 10.0
		}
		set {
			distanciaMilimetros = newValue * 10.0
		}
	}
	
	public var Milimetros : Double {
		get {
			return distanciaMilimetros
		}
		set {
			distanciaMilimetros = newValue
		}
	}
}