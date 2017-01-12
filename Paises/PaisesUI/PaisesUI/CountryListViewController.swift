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
	@IBAction func searchTextChanged(sender: UITextField) -> Void {
		if let filter = searchText?.text?.lowercaseString {
			filterCountries(filter)
		}
	}
	
	// Filtra a lista de paises
	private func filterCountries(filter : String) -> Void {
		var selectedCountries : [Country] = []
		
		for country in Country.allCountries {
			if country.name.lowercaseString.rangeOfString(filter) != nil {
				selectedCountries.append(country)
			}
		}
		
		self.filteredCountries = selectedCountries
	}
	
	// Prepara para apresentar a view de detalhes
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let navigator = segue.destinationViewController as? UINavigationController {
			if let detailView = navigator.viewControllers.first	as? CountryViewController {
				if let senderCountry = sender as? Country {
					showCountryDetails(detailView, country: senderCountry)
				}
			}
		}
	}
	
	// Apresenta os detalhes de um país
	private func showCountryDetails(detailView: CountryViewController, country: Country) -> Void {
		detailView.prepareToLoad()
		
		CountryRequest().getCountryData(country.code, callback: { country in
			dispatch_async(dispatch_get_main_queue(), {
				detailView.country = country
			})
		})
	}
	
	// Retorna o número de seções na tabela
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	// Retorna o número de linhas na seção
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredCountries.count
	}
	
	// Cria uma célula da seção
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
		cell.textLabel?.text = filteredCountries[indexPath.row].name
		cell.detailTextLabel?.text = filteredCountries[indexPath.row].continent.rawValue
		return cell
	}
	
	// Apresenta os detalhes quando clicar no acessório da tabela
	func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
		let country = filteredCountries[indexPath.row]
		performSegueWithIdentifier(countrySegueIdentifier, sender: country)
	}
}