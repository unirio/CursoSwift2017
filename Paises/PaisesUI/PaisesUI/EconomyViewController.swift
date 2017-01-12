//
//  EconomyViewController.swift
//  PaisesUI
//
//  Created by Marcio Barros on 11/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Paises

class EconomyViewController: UITableViewController {

	private let detailCellIdentifier = "cellDetail"
	
	private let basicCellIdentifier = "cellBasic"
	
	private var distribution : [(String, String)] = [];
	
	private var composition : [(String, String)] = [];
	
	private var agriculture : [String] = [];
	
	private var industries : [String] = [];
	
	// Indica o país representado na aba
	func setCountry(country : CountryDetails) {
		distribution = []
		distribution.append(("Gross Domestic Product", dataToUserRepresentation(country.grossDomesticProduct)))
		distribution.append(("Public debt", dataToUserRepresentation(country.publicDebt)))
		distribution.append(("Health expenditures", dataToUserRepresentation(country.healthExpenditure)))
		distribution.append(("Education expenditures", dataToUserRepresentation(country.educationExpenditure)))

		composition = []
		
		for component in country.grossDomesticProductComposition {
			composition.append((component.sector, String(component.percentile)))
		}
		
		agriculture = country.agricultureProducts
		industries = country.industries
		tableView.reloadData()
	}
	
	// Converte uma string para um formato legível pelo usuário
	private func dataToUserRepresentation(data: String) -> String {
		return (data.isEmpty) ? "Unknown" : data
	}
	
	// Retorna o número de seções da tabela
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 4
	}
	
	// Retorna o título de cada seção
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "GDP distribution"
		}
		
		if section == 1 {
			return "GDP composition"
		}
		
		if section == 2 {
			return "Agriculture products"
		}
		
		if section == 3 {
			return "Industrial products"
		}
		
		return ""
	}
	
	// Retorna o número de linhas de cada seção
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return distribution.count
		}
		
		if section == 1 {
			return composition.count
		}
		
		if section == 2 {
			return agriculture.count
		}
		
		if section == 3 {
			return industries.count
		}
		
		return 0
	}
	
	// Cria as colunas da tabela
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath)
			cell.textLabel?.text = distribution[indexPath.row].0
			cell.detailTextLabel?.text = distribution[indexPath.row].1
			return cell
		}
		
		if indexPath.section == 1 {
			let cell = tableView.dequeueReusableCellWithIdentifier(detailCellIdentifier, forIndexPath: indexPath)
			cell.textLabel?.text = composition[indexPath.row].0
			cell.detailTextLabel?.text = composition[indexPath.row].1
			return cell
		}
		
		if indexPath.section == 2 {
			let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier, forIndexPath: indexPath)
			cell.textLabel?.text = agriculture[indexPath.row]
			return cell
		}
		
		let cell = tableView.dequeueReusableCellWithIdentifier(basicCellIdentifier, forIndexPath: indexPath)
		cell.textLabel?.text = industries[indexPath.row]
		return cell
	}
}