//
//  GameScene.swift
//  Seaquest
//
//  Created by Marcio Barros on 11/26/14.
//  Copyright (c) 2014 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let startLabel = SKLabelNode(fontNamed:"Chalkduster")

    override func didMove(to view: SKView) {
        startLabel.text = "Começar!"
        startLabel.fontSize = 65;
        startLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(startLabel)
        self.backgroundColor = UIColor(hex: 0x80D9FF)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.startLabel {
                let skView = self.view!
				let scene = PlayScene(size: self.size)
                scene.scaleMode = .resizeFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
            }
        }
    }
}
