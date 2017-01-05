//
//  ViewController.swift
//  PaisesUI
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Paises

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet var table: UITableView!
	
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

	private var countryIdentifiers : [CountryIdentifier] = [] {
		didSet {
			table.reloadData()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

        // Register the table view cell class and its reuse id
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // This view controller itself will provide the delegate methods and row data for the table view.
        table.delegate = self
        table.dataSource = self

		// Load the country identifiers
		CountryRequest().getCountryIdentifiers({ self.countryIdentifiers = $0 })
	}

    // number of rows in table view
	func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryIdentifiers.count
    }

    // create a cell for each table view row
	func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = table.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!

        // set the text from the data model
        cell.textLabel?.text = self.countryIdentifiers[indexPath.row].Name
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(table: UITableView, didSelectRowAt indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}