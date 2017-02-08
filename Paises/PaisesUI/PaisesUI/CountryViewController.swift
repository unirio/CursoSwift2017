//
//  PaisViewController.swift
//  PaisesUI
//
//  Created by Marcio Barros on 10/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Paises

class CountryViewController: UITabBarController {

	private var isLoading = false

	private var economyViewController : EconomyViewController?
	
	private var geographyViewController : GeographyViewController?
	
	private var energyViewController : EnergyViewController?
	
	// País apresentado
	var country : CountryDetails? {
		didSet {
			self.title = country!.name
			economyViewController!.setCountry(country!)
			geographyViewController!.setCountry(country!)
			energyViewController!.setCountry(country!)
		}
	}
	
	// Indica que deve se preparar para carregar um país
	func prepareToLoad() {
		self.isLoading = true
	}
	
	// Indica que a view será apresentada
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = isLoading ? "Loading ..." : "No country selected"
		self.geographyViewController = self.viewControllers![0] as? GeographyViewController
		self.economyViewController = self.viewControllers![1] as? EconomyViewController
		self.energyViewController = self.viewControllers![2] as? EnergyViewController
	}
}
