//
//  GameScene.swift
//  Transitions
//
//  Created by Marcio Barros on 3/19/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class SecondScene: SKScene {
    override func didMove(to view: SKView) {
        let myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.text = "Segunda cena!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(myLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in: self)
			
			if location.x > self.frame.midX {
				let transition = TransitionFactory.createForwardTransition()
				let scene = ThirdScene(size: self.size)
                scene.scaleMode = .resizeFill
                self.view!.presentScene(scene, transition: transition)
			}
			else {
				let transition = TransitionFactory.createBackwardTransition()
				let scene = FirstScene(size: self.size)
                scene.scaleMode = .resizeFill
                self.view!.presentScene(scene, transition: transition)
			}
		}
    }
}
