//
//  GameScene.swift
//  Walk of Life
//
//  Created by Marcio Barros on 4/8/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	var walker : SKSpriteNode!

    override func didMove(to view: SKView) {
		backgroundColor = UIColor.white
		createWalker()
    }
	
	func createWalker() {
		let texture = SKTexture(imageNamed: "walk-00")
        walker = SKSpriteNode(texture: texture)
        walker.position = CGPoint(x: frame.midX, y: frame.midY)
        walker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(walker)
		
        let animationTexture = SKAction.animate(with: createTextures(), timePerFrame: 0.016)
        let walkerAnimation = SKAction.repeatForever(animationTexture)
        walker.run(walkerAnimation)
	}
	
	func createTextures() -> [SKTexture] {
		var textures : [SKTexture] = []
		
		for i in 0...29 {
			let name = String(format: "walk-%02d", i)
			let texture = SKTexture(imageNamed: name)
			textures += [texture]
		}
		
		return textures
	}
}
