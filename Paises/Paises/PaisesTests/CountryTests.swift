//
//  PaisesTests.swift
//  PaisesTests
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import XCTest
@testable import Paises

class CountryTests: XCTestCase {
    
	//
	// Confere se está pegando todos os países
	//
	func testCapturaIdentificadores() {
		let expectation = expectationWithDescription("longRunningFunction")
		
		CountryRequest().getCountryIdentifiers { (identifiers: [CountryIdentifier]) -> Void in
			XCTAssert(identifiers.count == 268)
			expectation.fulfill()
		}
  
		self.waitForExpectationsWithTimeout(5) { error in
			XCTAssertNil(error, "Something went horribly wrong")
		}
	}
    
	//
	// Confere os dados do Brasil
	//
    func testCapturaBrasil() {
		let expectation = expectationWithDescription("longRunningFunction")
		
		CountryRequest().getCountryData("br", callback: { (country: Country) -> Void in
			self.checkBrazil(country)
			expectation.fulfill()
		})
  
		self.waitForExpectationsWithTimeout(5) { error in
			XCTAssertNil(error, "Something went horribly wrong")
		}
    }
	
	// MARK: Métodos internos
	
	//
	// Confere os dados do Brasil
	//
	func checkBrazil(country: Country) {
		XCTAssert(country.Name == "BRAZIL")
		XCTAssert(country.AreaTotal == "8,515,770 sq km")
		XCTAssert(country.LandBoundaries == "16,145 km")
		XCTAssert(country.CoastlinePerimeter == "7,491 km")

		XCTAssert(country.NaturalResources.count == 13)
		XCTAssert(country.NaturalResources[0] == "bauxite")
		XCTAssert(country.NaturalResources[1] == "gold")
		XCTAssert(country.NaturalResources[2] == "iron ore")
		XCTAssert(country.NaturalResources[3] == "manganese")
		XCTAssert(country.NaturalResources[4] == "nickel")
		XCTAssert(country.NaturalResources[5] == "phosphates")
		XCTAssert(country.NaturalResources[6] == "platinum")
		XCTAssert(country.NaturalResources[7] == "tin")
		XCTAssert(country.NaturalResources[8] == "rare earth elements")
		XCTAssert(country.NaturalResources[9] == "uranium")
		XCTAssert(country.NaturalResources[10] == "petroleum")
		XCTAssert(country.NaturalResources[11] == "hydropower")
		XCTAssert(country.NaturalResources[12] == "timber")
		
		XCTAssert(country.Population == "205,823,665 (July 2016 est.)")
		XCTAssert(country.LifeExpectancy == "73.8 years")
		
		XCTAssert(country.GrossDomesticProduct == "$1.773 trillion (2015 est.)")
		XCTAssert(country.PublicDebt == "66.5% of GDP (2015 est.)")
		XCTAssert(country.HealthExpenditure == "8.3% of GDP (2014)")
		XCTAssert(country.EducationExpenditure == "5.9% of GDP (2012)")

		XCTAssert(country.GrossDomesticProductComposition.count == 3)
		XCTAssert(country.GrossDomesticProductComposition[0].Sector == "agriculture")
		XCTAssert(country.GrossDomesticProductComposition[0].Percentile == 5.9)
		XCTAssert(country.GrossDomesticProductComposition[1].Sector == "industry")
		XCTAssert(country.GrossDomesticProductComposition[1].Percentile == 22.2)
		XCTAssert(country.GrossDomesticProductComposition[2].Sector == "services")
		XCTAssert(country.GrossDomesticProductComposition[2].Percentile == 71.9)

		XCTAssert(country.AgricultureProducts.count == 8)
		XCTAssert(country.AgricultureProducts[0] == "coffee")
		XCTAssert(country.AgricultureProducts[1] == "soybeans")
		XCTAssert(country.AgricultureProducts[2] == "wheat")
		XCTAssert(country.AgricultureProducts[3] == "rice")
		XCTAssert(country.AgricultureProducts[4] == "corn")
		XCTAssert(country.AgricultureProducts[5] == "sugarcane")
		XCTAssert(country.AgricultureProducts[6] == "cocoa")
		XCTAssert(country.AgricultureProducts[7] == "citrus; beef")

		XCTAssert(country.Industries.count == 11)
		XCTAssert(country.Industries[0] == "textiles")
		XCTAssert(country.Industries[1] == "shoes")
		XCTAssert(country.Industries[2] == "chemicals")
		XCTAssert(country.Industries[3] == "cement")
		XCTAssert(country.Industries[4] == "lumber")
		XCTAssert(country.Industries[5] == "iron ore")
		XCTAssert(country.Industries[6] == "tin")
		XCTAssert(country.Industries[7] == "steel")
		XCTAssert(country.Industries[8] == "aircraft")
		XCTAssert(country.Industries[9] == "motor vehicles and parts")
		XCTAssert(country.Industries[10] == "other machinery and equipment")

		XCTAssert(country.EletricityProduction == "577 billion kWh (2014 est.)")
		XCTAssert(country.EletricityConsumption == "518 billion kWh (2014 est.)")
		XCTAssert(country.EletricityFossil == "18.7% of total installed capacity (2012 est.)")
		XCTAssert(country.EletricityHydroeletric == "69.3% of total installed capacity (2012 est.)")
		XCTAssert(country.EletricityNuclearFuels == "1.5% of total installed capacity (2012 est.)")
		XCTAssert(country.EletricityRenewableSources == "10.5% of total installed capacity (2012 est.)")
		
		XCTAssert(country.CrudeOilProduction == "2.437 million bbl/day (2015 est.)")
		XCTAssert(country.CrudeOilExports == "397,100 bbl/day (2013 est.)")
		XCTAssert(country.CrudeOilImports == "394,400 bbl/day (2013 est.)")
		XCTAssert(country.CrudeOilProvedReserves == "16 billion bbl (1 January 2016 es)")
	}

	//
	// Apresenta os dados de um país
	//
	func printCountry(country: Country) {
		print("===")
		print("Name: \(country.Name)")
		print("Area Total: \(country.AreaTotal)")
		print("Land Boundaries: \(country.LandBoundaries)")
		print("Coastline Perimeter: \(country.CoastlinePerimeter)")
		
		print("---")
		for naturalResource in country.NaturalResources {
			print("Natural Resource: \(naturalResource)")
		}
		
		print("---")
		print("Population: \(country.Population)")
		print("Life Exp.: \(country.LifeExpectancy)")
		
		print("---")
		print("GDP: \(country.GrossDomesticProduct)")
		
		for component in country.GrossDomesticProductComposition {
			print("GDP component: \(component.Sector) - \(component.Percentile)")
		}
		
		print("Public Debt: \(country.PublicDebt)")
		print("Health Exp.: \(country.HealthExpenditure)")
		print("Education Exp.: \(country.EducationExpenditure)")
		
		print("---")
		for product in country.AgricultureProducts {
			print("Agriculture: \(product)")
		}
		
		for product in country.Industries {
			print("Industry: \(product)")
		}
		
		print("---")
		print("Elec. Production: \(country.EletricityProduction)")
		print("Elec. Consumption: \(country.EletricityConsumption)")
		print("Elec. Fossil: \(country.EletricityFossil)")
		print("Elec. Hydro: \(country.EletricityHydroeletric)")
		print("Elec. Nuclear: \(country.EletricityNuclearFuels)")
		print("Elec. Renewable: \(country.EletricityRenewableSources)")
		
		print("---")
		print("Crude Production: \(country.CrudeOilProduction)")
		print("Crude Exports: \(country.CrudeOilExports)")
		print("Crude Imports: \(country.CrudeOilImports)")
		print("Crude Reserves: \(country.CrudeOilProvedReserves)")
		print("===")
	}
}