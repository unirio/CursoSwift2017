//
//  GameViewController.swift
//  Transitions
//
//  Created by Marcio Barros on 3/19/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let skView = self.view as! SKView
		skView.showsFPS = true
		skView.showsNodeCount = true
		skView.ignoresSiblingOrder = true

		let scene = FirstScene()
		scene.size = skView.bounds.size
		scene.scaleMode = .aspectFill
		skView.presentScene(scene)
    }
}
