//
//  GameScene.swift
//  Starfield
//
//  Created by Marcio Barros on 3/4/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	var starfield: ParallaxStarfieldNode!
	
	/*
	 * Creates the parallax starfield
	 */
    override func didMove(to view: SKView) {
		starfield = ParallaxStarfieldNode(size: view.bounds.size)
		starfield.addStarfield(50, color: UIColor.red, speed: 0.25)
		starfield.addStarfield(75, color: UIColor.yellow, speed: 0.50)
		starfield.addStarfield(100, color: UIColor.white, speed: 1.0)
		starfield.position = CGPoint(x: 0.0, y: 0.0)
		self.addChild(starfield)
    }
	
	/*
	 * Changes gravity according to touch
	 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in: self)
			
			let hg = (location.x - frame.midX) / (frame.maxX - frame.midX)
			starfield.horizontalGravity += hg

			let vg = -(location.y - frame.midY) / (frame.maxY - frame.midY)
			starfield.verticalGravity += vg
		}
    }
	
	/*
	 * Updates the starfield
	 */
    override func update(_ currentTime: TimeInterval) {
		starfield.update()
	}
}
