//
//  Pais.swift
//  Paises
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

public class Country {
	
	public var Name = ""
	public var AreaTotal = ""
	public var LandBoundaries = ""
	public var CoastlinePerimeter = ""
	public var NaturalResources : [String] = []
	
	public var Population = ""
	public var LifeExpectancy = ""
	
	public var GrossDomesticProduct = ""
	public var GrossDomesticProductComposition : [CountryGrossDomesticProductComponent] = []
	public var PublicDebt = ""
	public var HealthExpenditure = ""
	public var EducationExpenditure = ""
	
	public var AgricultureProducts : [String] = []
	public var Industries : [String] = []
	
	public var EletricityProduction = ""
	public var EletricityConsumption = ""
	public var EletricityFossil = ""
	public var EletricityHydroeletric = ""
	public var EletricityNuclearFuels = ""
	public var EletricityRenewableSources = ""
	
	public var CrudeOilProduction = ""
	public var CrudeOilExports = ""
	public var CrudeOilImports = ""
	public var CrudeOilProvedReserves = ""
}

//
// Classe que representa um componente de GDP de um país
//
public class CountryGrossDomesticProductComponent {
	public var Sector = ""
	public var Percentile = 0.0
	
	convenience init(sector: String, percentile: Double) {
		self.init()
		self.Sector	= sector
		self.Percentile = percentile
	}
}