//
//  Pais.swift
//  Paises
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

public class CountryDetails {
	
	public var name = ""
	public var totalArea = ""
	public var landBoundaries = ""
	public var coastlinePerimeter = ""
	public var naturalResources : [String] = []
	
	public var population = ""
	public var lifeExpectancy = ""
	
	public var grossDomesticProduct = ""
	public var grossDomesticProductComposition : [(sector: String, percentile: Double)] = []
	public var publicDebt = ""
	public var healthExpenditure = ""
	public var educationExpenditure = ""
	
	public var agricultureProducts : [String] = []
	public var industries : [String] = []
	
	public var eletricityProduction = ""
	public var eletricityConsumption = ""
	public var eletricityFossil = ""
	public var eletricityHydroeletric = ""
	public var eletricityNuclearFuels = ""
	public var eletricityRenewableSources = ""
	
	public var crudeOilProduction = ""
	public var crudeOilExports = ""
	public var crudeOilImports = ""
	public var crudeOilProvedReserves = ""
}
