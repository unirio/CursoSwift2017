//
//  ViewControllerTableViewController.swift
//  PaisesUI
//
//  Created by Marcio Barros on 10/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Paises

class CountryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	private let cellReuseIdentifier = "cellPais"
	
	private let countrySegueIdentifier = "countrySegue"
	
	@IBOutlet weak var searchText : UITextField?
	
	@IBOutlet weak var table : UITableView?
	
	// Paises que devem ser apresentados na lista
	private var filteredCountries = Country.allCountries {
		didSet {
			if table != nil {
				table!.reloadData()
			}
		}
	}
	
	// Prepara a tabela quando a view for apresentada
	override func viewDidLoad() {
		super.viewDidLoad()
		table!.delegate = self
		table!.dataSource = self
	}
	
	// Captura mudanças no filtro
	@IBAction func searchTextChanged(_ sender: UITextField) -> Void {
		if let filter = searchText?.text?.lowercased() {
			filterCountries(filter: filter)
		}
	}
	
	// Filtra a lista de paises
	private func filterCountries(filter : String) -> Void {
		var selectedCountries : [Country] = []
		
		for country in Country.allCountries {
			if country.name.lowercased().range(of: filter) != nil {
				selectedCountries.append(country)
			}
		}
		
		self.filteredCountries = selectedCountries
	}
	
	// Prepara para apresentar a view de detalhes
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let navigator = segue.destination as? UINavigationController {
			if let detailView = navigator.viewControllers.first	as? CountryViewController {
				if let senderCountry = sender as? Country {
					showCountryDetails(detailView: detailView, country: senderCountry)
				}
			}
		}
	}
	
	// Apresenta os detalhes de um país
	private func showCountryDetails(detailView: CountryViewController, country: Country) -> Void {
		detailView.prepareToLoad()
		
		CountryRequest().getCountryData(country.code, callback: { country in
			DispatchQueue.main.async(execute: {
				detailView.country = country
			})
		})
	}
	
	// Retorna o número de seções na tabela
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	// Retorna o número de linhas na seção
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredCountries.count
	}
	
	// Cria uma célula da seção
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
		cell.textLabel?.text = filteredCountries[indexPath.row].name
		cell.detailTextLabel?.text = filteredCountries[indexPath.row].continent.rawValue
		return cell
	}
	
	// Apresenta os detalhes quando clicar no acessório da tabela
	func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		let country = filteredCountries[indexPath.row]
		performSegue(withIdentifier: countrySegueIdentifier, sender: country)
	}
}
