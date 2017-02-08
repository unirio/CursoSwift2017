//
//  EnergiaViewController.swift
//  PaisesUI
//
//  Created by Marcio Barros on 11/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Paises

class EnergyViewController: UITableViewController {

	private let basicCellIdentifier = "cellBasic"
	
	private var eletricity : [(String, String)] = [];
	
	private var crudeOil : [(String, String)] = [];
	
	// Indica o país representado na aba
	func setCountry(_ country : CountryDetails) {
		eletricity = []
		eletricity.append(("Eletricity production", dataToUserRepresentation(country.eletricityProduction)))
		eletricity.append(("Eletricity comsumption", dataToUserRepresentation(country.eletricityConsumption)))
		eletricity.append(("Eletricity from fossil sources", dataToUserRepresentation(country.eletricityFossil)))
		eletricity.append(("Eletricity from hydroeletric", dataToUserRepresentation(country.eletricityHydroeletric)))
		eletricity.append(("Eletricity from nuclear fuels", dataToUserRepresentation(country.eletricityNuclearFuels)))
		eletricity.append(("Eletricity from renewable sources", dataToUserRepresentation(country.eletricityRenewableSources)))
		
		crudeOil = []
		crudeOil.append(("Crude oil production", dataToUserRepresentation(country.crudeOilProduction)))
		crudeOil.append(("Crude oil exports", dataToUserRepresentation(country.crudeOilExports)))
		crudeOil.append(("Crude oil imports", dataToUserRepresentation(country.crudeOilImports)))
		crudeOil.append(("Crude oil proven reserves", dataToUserRepresentation(country.crudeOilProvedReserves)))
		
		tableView.reloadData()
	}

	// Converte uma string para um formato legível pelo usuário
	fileprivate func dataToUserRepresentation(_ data: String) -> String {
		return (data.isEmpty) ? "Unknown" : data
	}

	// Retorna o número de seções da tabela
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
	
	// Retorna o título de cada seção
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Eletricity"
		}
		
		if section == 1 {
			return "Petroleum"
		}
		
        return ""
	}

	// Retorna o número de linhas de cada seção
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return eletricity.count
		}
		
		if section == 1 {
			return crudeOil.count
		}
		
        return 0
    }

	// Cria as colunas da tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: basicCellIdentifier, for: indexPath)
		
		if indexPath.section == 0 {
			cell.textLabel?.text = eletricity[indexPath.row].0
			cell.detailTextLabel?.text = eletricity[indexPath.row].1
		}
		
		if indexPath.section == 1 {
			cell.textLabel?.text = crudeOil[indexPath.row].0
			cell.detailTextLabel?.text = crudeOil[indexPath.row].1
		}
		
        return cell
    }
}
