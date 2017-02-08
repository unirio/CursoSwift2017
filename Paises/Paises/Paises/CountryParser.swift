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
	func execute(_ content: String) -> CountryDetails {
		
		let country = CountryDetails()
		
		parseName(content: content, country: country)
		parseTotalArea(content: content, country: country)
		parseLandBoundaries(content: content, country: country)
		parseCoastlinePerimeter(content: content, country: country)
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
	private func parseString(pattern: String, content: String, country: CountryDetails, callback: (CountryDetails, String) -> Void) -> Bool {
		let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
		let range = NSMakeRange(0, content.characters.count)

		if let match = regex.firstMatch(in: content, options: [], range: range) {
			let name = (content as NSString).substring(with: match.rangeAt(1))
			callback(country, name)
			return true
		}

		return false
	}
	
	//
	// Captura as informações na forma de uma lista separada por vírgulas
	//
	private func parseStringList(pattern: String, content: String, country: CountryDetails, callback: (CountryDetails, String) -> Void) -> Bool {
		let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
		let range = NSMakeRange(0, content.characters.count)

		if let match = regex.firstMatch(in: content, options: [], range: range) {
			let data = (content as NSString).substring(with: match.rangeAt(1))
			let tokens = data.components(separatedBy: ",")
			
			for token in tokens {
				callback(country, token.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
			}
			
			return true
		}

		return false
	}
	
	// MARK: geografia
	
	//
	// Captura o nome
	//
	private func parseName(content: String, country: CountryDetails) -> Bool {
		let pattern = "<span class=\"region_name1 countryName \">(.+)</span>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.name = $1 })
	}
	
	//
	// Captura a área total
	//
	private func parseTotalArea(content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Area:.+?<\\/div>\\s*<div><span class=category>total: </span><span class=category_data>(.+)</span></div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.totalArea = $1 })
	}
	
	//
	// Captura o perímetro total
	//
	private func parseLandBoundaries(content: String, country: CountryDetails) -> Bool {
		let patternBasic = "<div.+?Land boundaries:.+?<\\/div>\\s*<div><span class=category>.*?total: </span><span class=category_data>(.+)</span></div>"

		if parseString(pattern: patternBasic, content: content, country: country, callback: { $0.landBoundaries = $1 }) {
			return true
		}

		let patternSimple = "<div.+?Land boundaries:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"

		if parseString(pattern: patternSimple, content: content, country: country, callback: { $0.landBoundaries = $1 }) {
			return true
		}
		
		return false
	}
	
	//
	// Captura o perímetro de costas marítimas
	//
	private func parseCoastlinePerimeter(content: String, country: CountryDetails) -> Bool {
		let patternBasic = "<div.+?Coastline:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"

		if parseString(pattern: patternBasic, content: content, country: country, callback: { $0.coastlinePerimeter = $1 }) {
			return true
		}
		
		let patternCompound = "<div.+?Coastline:.+?<\\/div>\\s*<div><span class=category>.*?total: </span><span class=category_data>(.+)</span></div>"

		if parseString(pattern: patternCompound, content: content, country: country, callback: { $0.coastlinePerimeter = $1 }) {
			return true
		}
		
		return false
	}
	
	//
	// Captura os recursos naturais
	//
	private func parseNaturalResources(_ content: String, country: CountryDetails) -> Bool {
		let patternBasic = "<div.+?Natural resources:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"

		if parseStringList(pattern: patternBasic, content: content, country: country, callback: { $0.naturalResources.append($1) }) {
			return true
		}
		
		let patternCompound = "<div.+?Natural resources:.+?<\\/div>\\s*<div><span class=category>.*?: </span><span class=category_data>(.+)</span></div>"

		if parseStringList(pattern: patternCompound, content: content, country: country, callback: { $0.naturalResources.append($1) }) {
			return true
		}
		
		return false
	}
	
	// MARK: população
	
	//
	// Captura o população total
	//
	private func parsePopulation(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Population:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.population = $1 })
	}
	
	//
	// Captura a expectativa média de vida
	//
	private func parseLifeExpectancy(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Life expectancy at birth:.+?<\\/div>\\s*<div><span class=category>total population: </span><span class=category_data>(.+)</span></div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.lifeExpectancy = $1 })
	}
	
	// MARK: economia
	
	//
	// Captura o produto interno bruto
	//
	private func parseGrossDomesticProduct(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?GDP \\(official exchange rate\\):.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.grossDomesticProduct = $1 })
	}
	
	//
	// Captura os principais componentes do GDP
	//
	private func parseGrossDomesticProductComposition(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?GDP - composition, by sector of origin:.+?<\\/div>\\s*(.+?)\\s*<div id='field'"
		let aContent = content.replacingOccurrences(of: "\n", with: " ", options: NSString.CompareOptions.literal, range: nil)
		return parseString(pattern: pattern, content: aContent, country: country, callback: { self.parseCompositionComponents($0, content: $1) })
	}
	
	//
	// Método interno para capturar os componentes do GDP
	//
	private func parseCompositionComponents(_ country: CountryDetails, content: String) {
		let pattern = "<div><span class=category>(.+?): <\\/span><span class=category_data>(.+?)%( \\(.*\\))?<\\/span>"
		let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
		let range = NSMakeRange(0, content.characters.count)
		let matches = regex.matches(in: content, options: [], range: range)
		
		for match in matches {
			let sector = (content as NSString).substring(with: match.rangeAt(1))
			
			if let percentile = Double((content as NSString).substring(with: match.rangeAt(2))) {
				country.grossDomesticProductComposition.append((sector: sector, percentile: percentile))
			}
		}
	}
	
	//
	// Captura o volume de dívida como um percentual do GDP
	//
	private func parsePublicDebt(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Public debt:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.publicDebt = $1 })
	}
	
	//
	// Captura o percentual do GDP investido em saúde
	//
	private func parseHealthExpenditure(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Health expenditures:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.healthExpenditure = $1 })
	}
	
	//
	// Captura o percentual do GDP investido em educação
	//
	private func parseEducationExpenditure(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Education expenditures:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.educationExpenditure = $1 })
	}

	//
	// Captura os principais produtos agrícolas
	//
	private func parseAgricultureProducts(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Agriculture - products:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseStringList(pattern: pattern, content: content, country: country, callback: { $0.agricultureProducts.append($1) })
	}
	
	//
	// Captura os principais produtos industriais
	//
	private func parseIndustries(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Industries:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseStringList(pattern: pattern, content: content, country: country, callback: { $0.industries.append($1) })
	}
	
	// MARK: setor elétrico
	
	//
	// Captura a produção elétrica total
	//
	private func parseEletricityProduction(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Electricity - production:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.eletricityProduction = $1 })
	}
	
	//
	// Captura o consumo elétrico total
	//
	private func parseEletricityConsumption(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Electricity - consumption:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.eletricityConsumption = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes fósseis
	//
	private func parseEletricityFossil(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Electricity - from fossil fuels:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.eletricityFossil = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes hidroelétricas
	//
	private func parseEletricityHydroeletric(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Electricity - from hydroelectric plants:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.eletricityHydroeletric = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes nucleares
	//
	private func parseEletricityNuclearFuels(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Electricity - from nuclear fuels:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.eletricityNuclearFuels = $1 })
	}
	
	//
	// Captura a produção elétrica de fontes renováveis
	//
	private func parseEletricityRenewableSources(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Electricity - from other renewable sources:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.eletricityRenewableSources = $1 })
	}
	
	// MARK: setor petróleo
	
	//
	// Captura o volume produzido de petróleo
	//
	private func parseCrudeOilProduction(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Crude oil - production:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.crudeOilProduction = $1 })
	}
	
	//
	// Captura o volume exportado de petróleo
	//
	private func parseCrudeOilExports(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Crude oil - exports:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.crudeOilExports = $1 })
	}
	
	//
	// Captura o volume importado de petróleo
	//
	private func parseCrudeOilImports(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Crude oil - imports:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.crudeOilImports = $1 })
	}
	
	//
	// Captura o volume de reservas de petróleo
	//
	private func parseCrudeOilProvedReserves(_ content: String, country: CountryDetails) -> Bool {
		let pattern = "<div.+?Crude oil - proved reserves:.+?<\\/div>\\s*<div class=category_data>(.+)</div>"
		return parseString(pattern: pattern, content: content, country: country, callback: { $0.crudeOilProvedReserves = $1 })
	}
}
