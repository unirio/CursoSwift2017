//
//  GameViewController.swift
//  Starfield
//
//  Created by Marcio Barros on 3/4/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		let scene = GameScene(size: view.bounds.size)

		/* Configure the view. */
		let skView = self.view as! SKView
		skView.showsFPS = true
		skView.showsNodeCount = true
		
		/* Sprite Kit applies additional optimizations to improve rendering performance */
		skView.ignoresSiblingOrder = true
		
		/* Set the scale mode to scale to fit the window */
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
