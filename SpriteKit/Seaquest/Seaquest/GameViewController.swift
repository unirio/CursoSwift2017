//
//  GameViewController.swift
//  Seaquest
//
//  Created by Marcio Barros on 11/26/14.
//  Copyright (c) 2014 UNIRIO. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Configure the view to optimize rendering
		let skView = self.view as! SKView
		skView.showsFPS = false
		skView.showsNodeCount = false
		skView.ignoresSiblingOrder = true
		
		// Set the scale mode to scale to fit the window
		let scene = GameScene()
		scene.size = skView.bounds.size
		scene.scaleMode = .aspectFill
		skView.presentScene(scene)
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
