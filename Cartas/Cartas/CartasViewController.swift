//
//  ViewController.swift
//  Cartas
//
//  Created by Marcio Barros on 27/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

class CartasViewController: UIViewController {

	@IBOutlet weak var naipe: NaipePaus!
	
	override func viewDidAppear(_ animated: Bool) {
		naipe.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI) * 3 / 4)
	}

}

