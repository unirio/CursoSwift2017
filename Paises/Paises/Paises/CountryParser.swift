//
//  CountryParser.swift
//  Paises
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

class CountryParser {
	
	//
	// Método principal de captura dos dados de um país
	//
	func execute(content: String) -> Country {
		
		let country = Country()
		
		parseName(content, country: country)
		parseTotalArea(content, country: country)
		parseLandBoundaries(content, country: country)
		parseCoastlinePerimeter(content, country: country)
		parseNaturalResources(content, country: country)

		parsePopulation(content, country: country)
		parseLifeExpectancy(content, country: country)
		
		parseGrossDomesticProduct(content, country: country)
		parseGrossDomesticProductComposition(content, country: country)
		parsePublicDebt(content, country: country)
		parseHealthExpenditure(content, country: country)
		parseEducationExpenditure(content, country: country)
		
		parseAgricultureProducts(content, country: country)
		parseIndustries(content, country: country)
		
		parseEletricityProduction(content, country: country)
		parseEletricityConsumption(content, country: country)
		parseEletricityFossil (content, country: country)
		parseEletricityHydroeletric(content, country: country)
		parseEletricityNuclearFuels(content, country: country)
		parseEletricityRenewableSources(content, country: country)
		
		parseCrudeOilProduction(content, country: country)
		parseCrudeOilExports(content, country: country)
		parseCrudeOilImports(content, country: country)
		parseCrudeOilProvedReserves(content, country: country)

		return country
	}

	// MARK: suporte
	
	//
	// Captura as informações na forma de string
	//
	private func parseString(pattern: String, content: String, country: Country, callback: (Country, String) -> Void) -> Bool {
		let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
		let range = NSMakeRange(0, content.characters.count)

		if let match = regex.firstMatchInString(content, options: [], range: range) {
			let name = (content as NSString).substringWithRange(match.rangeAtIndex(1))
			callback(country, name)
			return true
		}

		return false
	}
	
	//
	// Captura as informações na forma de uma lista separada por vírgulas
	//
	private func parseStringList(pattern: String, content: String, country: Country, callback: (Country, String) -> Void) -> Bool {
		let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
		let range = NSMakeRange(0, content.characters.count)

		if let match = regex.firstMatchInString(content, options: [], range: range) {
			let data = (content as NSString).substringWithRange(match.rangeAtIndex(1))
			let tokens = data.componentsSeparatedByString(",")
			
			for token in tokens {
				callback(country, token.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
			}
			
			return true
		}

		return false
	}
	
	// MARK: geografia
	
	//
	// Captura o nome
	//
	private func parseName(content: String, country: Country) -> Bool {
		let pattern = "<span class=\"region_name1 countryName \">(.+)</span>"
		return parseString(pattern, content: content, country: country, callback: { $0.Name = $1 })
	}
	
	//
	// Captura a área total
	//
	private func parseTotalArea(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Area:.+?<\\/div>\\s*<div><span class=category>total: </span><span class=category_data>(.+)</span></div>"
		return parseString(pattern, content: content, country: country, callback: { $0.AreaTotal = $1 })
	}
	
	//
	// Captura o perímetro total
	//
	private func parseLandBoundaries(content: String, country: Country) -> Bool {
		let patternBasic = "<div.+?Land boundaries:.+?<\\/div>\\s*<div><span class=category>.*?total: </span><span class=category_data>(.+)</span></div>"

		if parseString(patternBasic, content: content, country: country, callback: { $0.LandBoundaries = $1 }) {
			return true
		}

		let patternSimple = "<div.+?Land boundaries:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"

		if parseString(patternSimple, content: content, country: country, callback: { $0.LandBoundaries = $1 }) {
			return true
		}
		
		return false
	}
	
	//
	// Captura o perímetro de costas marítimas
	//
	private func parseCoastlinePerimeter(content: String, country: Country) -> Bool {
		let patternBasic = "<div.+?Coastline:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"

		if parseString(patternBasic, content: content, country: country, callback: { $0.CoastlinePerimeter = $1 }) {
			return true
		}
		
		let patternCompound = "<div.+?Coastline:.+?<\\/div>\\s*<div><span class=category>.*?total: </span><span class=category_data>(.+)</span></div>"

		if parseString(patternCompound, content: content, country: country, callback: { $0.CoastlinePerimeter = $1 }) {
			return true
		}
		
		return false
	}
	
	//
	// Captura os recursos naturais
	//
	private func parseNaturalResources(content: String, country: Country) -> Bool {
		let patternBasic = "<div.+?Natural resources:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"

		if parseStringList(patternBasic, content: content, country: country, callback: { $0.NaturalResources.append($1) }) {
			return true
		}
		
		let patternCompound = "<div.+?Natural resources:.+?<\\/div>\\s*<div><span class=category>.*?: </span><span class=category_data>(.+)</span></div>"

		if parseStringList(patternCompound, content: content, country: country, callback: { $0.NaturalResources.append($1) }) {
			return true
		}
		
		return false
	}
	
	// MARK: população
	
	//
	// Captura o população total
	//
	private func parsePopulation(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Population:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.Population = $1 })
	}
	
	//
	// Captura a expectativa média de vida
	//
	private func parseLifeExpectancy(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Life expectancy at birth:.+?<\\/div>\\s*<div><span class=category>total population: </span><span class=category_data>(.+)</span></div>"
		return parseString(pattern, content: content, country: country, callback: { $0.LifeExpectancy = $1 })
	}
	
	// MARK: economia
	
	//
	// Captura o produto interno bruto
	//
	private func parseGrossDomesticProduct(content: String, country: Country) -> Bool {
		let pattern = "<div.+?GDP \\(official exchange rate\\):.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.GrossDomesticProduct = $1 })
	}
	
	//
	// Captura os principais componentes do GDP
	//
	private func parseGrossDomesticProductComposition(content: String, country: Country) -> Bool {
		let pattern = "<div.+?GDP - composition, by sector of origin:.+?<\\/div>\\s*(.+?)\\s*<div id='field'"
		let aContent = content.stringByReplacingOccurrencesOfString("\n", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil)
		return parseString(pattern, content: aContent, country: country, callback: { self.parseCompositionComponents($0, content: $1) })
	}
	
	//
	// Método interno para capturar os componentes do GDP
	//
	private func parseCompositionComponents(country: Country, content: String) {
		let pattern = "<div><span class=category>(.+?): <\\/span><span class=category_data>(.+?)%( \\(.*\\))?<\\/span>"
		let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
		let range = NSMakeRange(0, content.characters.count)
		let matches = regex.matchesInString(content, options: [], range: range)
		
		for match in matches {
			let sector = (content as NSString).substringWithRange(match.rangeAtIndex(1))
			
			if let percentile = Double((content as NSString).substringWithRange(match.rangeAtIndex(2))) {
				let component = CountryGrossDomesticProductComponent(sector: sector, percentile: percentile)
				country.GrossDomesticProductComposition.append(component)
			}
		}
	}
	
	//
	// Captura o volume de dívida como um percentual do GDP
	//
	private func parsePublicDebt(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Public debt:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.PublicDebt = $1 })
	}
	
	//
	// Captura o percentual do GDP investido em saúde
	//
	private func parseHealthExpenditure(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Health expenditures:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.HealthExpenditure = $1 })
	}
	
	//
	// Captura o percentual do GDP investido em educação
	//
	private func parseEducationExpenditure(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Education expenditures:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EducationExpenditure = $1 })
	}

	//
	// Captura os principais produtos agrícolas
	//
	private func parseAgricultureProducts(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Agriculture - products:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseStringList(pattern, content: content, country: country, callback: { $0.AgricultureProducts.append($1) })
	}
	
	//
	// Captura os principais produtos industriais
	//
	private func parseIndustries(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Industries:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseStringList(pattern, content: content, country: country, callback: { $0.Industries.append($1) })
	}
	
	// MARK: setor elétrico
	
	//
	// Captura a produção elétrica total
	//
	private func parseEletricityProduction(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Electricity - production:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EletricityProduction = $1 })
	}
	
	//
	// Captura o consumo elétrico total
	//
	private func parseEletricityConsumption(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Electricity - consumption:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EletricityConsumption = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes fósseis
	//
	private func parseEletricityFossil(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Electricity - from fossil fuels:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EletricityFossil = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes hidroelétricas
	//
	private func parseEletricityHydroeletric(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Electricity - from hydroelectric plants:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EletricityHydroeletric = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes nucleares
	//
	private func parseEletricityNuclearFuels(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Electricity - from nuclear fuels:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EletricityNuclearFuels = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes renováveis
	//
	private func parseEletricityRenewableSources(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Electricity - from other renewable sources:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.EletricityRenewableSources = $1 })
	}
	
	// MARK: setor petróleo
	
	//
	// Captura o volume produzido de petróleo
	//
	private func parseCrudeOilProduction(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Crude oil - production:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.CrudeOilProduction = $1 })
	}
	
	//
	// Captura o volume exportado de petróleo
	//
	private func parseCrudeOilExports(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Crude oil - exports:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.CrudeOilExports = $1 })
	}
	
	//
	// Captura o volume importado de petróleo
	//
	private func parseCrudeOilImports(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Crude oil - imports:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.CrudeOilImports = $1 })
	}
	
	//
	// Captura o volume de reservas de petróleo
	//
	private func parseCrudeOilProvedReserves(content: String, country: Country) -> Bool {
		let pattern = "<div.+?Crude oil - proved reserves:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern, content: content, country: country, callback: { $0.CrudeOilProvedReserves = $1 })
	}
}