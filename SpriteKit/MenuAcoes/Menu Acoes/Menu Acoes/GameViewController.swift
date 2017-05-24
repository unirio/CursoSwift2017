//
//  GameViewController.swift
//  Menu Acoes
//
//  Created by Marcio Barros on 4/10/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed: "GameScene") {
			let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
			scene.scaleMode = .aspectFit
            skView.presentScene(scene)
        }
    }
}
