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
	
	override func viewDidAppear(animated: Bool) {
		naipe.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * 3 / 4)
	}

}

