//
//  GameViewController.swift
//  Walk of Life
//
//  Created by Marcio Barros on 4/8/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		let scene = GameScene(size: view.bounds.size)
		
		let skView = self.view as! SKView
		skView.showsFPS = true
		skView.showsNodeCount = true
		skView.ignoresSiblingOrder = true
		
		scene.scaleMode = .aspectFill
		skView.presentScene(scene)
    }
}
