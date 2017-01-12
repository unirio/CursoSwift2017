//
//  GeoViewController.swift
//  PaisesUI
//
//  Created by Marcio Barros on 11/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Paises

class GeographyViewController: UITableViewController {
	
	private let detailCellIdentifier = "cellDetail"
	
	private let basicCellIdentifier = "cellBasic"
	
	private var areas : [(String, String)] = [];
	
	private var naturalResources : [String] = [];
	
	private var population : [(String, String)] = [];
	
	// Indica o país representado na aba
	func setCountry(country : CountryDetails) {
		areas = []
		areas.append(("Total area", dataToUserRepresentation(country.totalArea)))
		areas.append(("Land boundaries", dataToUserRepresentation(country.landBoundaries)))
		areas.append(("Coastline perimeter", dataToUserRepresentation(country.coastlinePerimeter)))
		
		naturalResources = country.naturalResources
		
		population = []
		population.append(("Population", dataToUserRepresentation(country.population)))
		population.append(("Life expectancy", dataToUserRepresentation(country.lifeExpectancy)))
		
		tableView.reloadData()
	}
	
	// Converte uma string para um formato legível pelo usuário
	private func dataToUserRepresentation(data: String) -> String {
		return (data.isEmpty) ? "Unknown" : data
	}
	
	// Retorna o número de seções da tabela
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 3
	}
	
	// Retorna o título de cada seção
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Areas"
		}
		
		if section == 1 {
			return "Natural resources"
		}
		
		if section == 2 {
			return "Population"
		}
		
		return ""
	}
	
	// Retorna o número de linhas de cada seção
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return areas.count
		}
		
		if section == 1 {
			return naturalResources.count
		}
		
		if section == 2 {
			return population.count
		}
		
		return 0
	}
	
	// Cria as colunas da tabela
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath)
			cell.textLabel?.text = areas[indexPath.row].0
			cell.detailTextLabel?.text = areas[indexPath.row].1
			return cell
		}
		
		if indexPath.section == 1 {
			let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier, forIndexPath: indexPath)
			cell.textLabel?.text = naturalResources[indexPath.row]
			return cell
		}
		
		let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath)
		cell.textLabel?.text = population[indexPath.row].0
		cell.detailTextLabel?.text = population[indexPath.row].1
		return cell
	}
}