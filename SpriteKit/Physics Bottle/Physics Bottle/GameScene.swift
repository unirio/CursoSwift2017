//
//  GameScene.swift
//  Physics Bottle
//
//  Created by Marcio Barros on 2/26/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

extension Float {
	static func range(_ min: CGFloat, max: CGFloat) -> CGFloat {
		return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
	}
}

class GameScene: SKScene {
    override func didMove(to view: SKView) {
		let sprite: SKSpriteNode = SKSpriteNode(imageNamed: "bottle.png")
		sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 0.75)

		let path: CGMutablePath = CGMutablePath()
		MoveToPoint(path,    x: 29, y: 139, node: sprite)
		AddLineToPoint(path, x: 19, y: 139, node: sprite)
		AddLineToPoint(path, x: 19, y: 130, node: sprite)
		AddLineToPoint(path, x: 9,  y: 130, node: sprite)
		AddLineToPoint(path, x: 9,  y: 120, node: sprite)
		AddLineToPoint(path, x: 19, y: 120, node: sprite)
		AddLineToPoint(path, x: 19, y: 109, node: sprite)
		AddLineToPoint(path, x: 0,  y: 90,  node: sprite)
		AddLineToPoint(path, x: 0,  y: 20,  node: sprite)
		AddLineToPoint(path, x: 19, y: 0,   node: sprite)
		AddLineToPoint(path, x: 79, y: 0,   node: sprite)
		AddLineToPoint(path, x: 99, y: 20,  node: sprite)
		AddLineToPoint(path, x: 99, y: 90,  node: sprite)
		AddLineToPoint(path, x: 79, y: 110, node: sprite)
		AddLineToPoint(path, x: 80, y: 120, node: sprite)
		AddLineToPoint(path, x: 89, y: 120, node: sprite)
		AddLineToPoint(path, x: 89, y: 130, node: sprite)
		AddLineToPoint(path, x: 79, y: 131, node: sprite)
		AddLineToPoint(path, x: 79, y: 139, node: sprite)
		AddLineToPoint(path, x: 69, y: 139, node: sprite)
		AddLineToPoint(path, x: 69, y: 100, node: sprite)
		AddLineToPoint(path, x: 89, y: 79,  node: sprite)
		AddLineToPoint(path, x: 89, y: 30,  node: sprite)
		AddLineToPoint(path, x: 69, y: 10,  node: sprite)
		AddLineToPoint(path, x: 30, y: 10,  node: sprite)
		AddLineToPoint(path, x: 9,  y: 31,  node: sprite)
		AddLineToPoint(path, x: 9,  y: 76,  node: sprite)
		AddLineToPoint(path, x: 29, y: 100, node: sprite)
		path.closeSubpath()
			
		sprite.physicsBody = SKPhysicsBody(polygonFrom: path)
		sprite.physicsBody?.isDynamic = false
		sprite.zPosition = 10
		self.addChild(sprite)

		self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 0.05), SKAction.run(self.generateFluid)])))
		sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 10), SKAction.rotate(byAngle: CGFloat(2 * Double.pi), duration: 5.0)])))
    }
	
	func offset(_ node: SKSpriteNode, isX: Bool)->CGFloat {
		return isX ? node.frame.size.width * node.anchorPoint.x : node.frame.size.height * node.anchorPoint.y
	}
		
	func AddLineToPoint(_ path: CGMutablePath, x: CGFloat, y: CGFloat, node: SKSpriteNode) {
		path.addLine(to: CGPoint(x: (x * 2) - offset(node, isX: true), y: (y * 2) - offset(node, isX: false)))
	}
		
	func MoveToPoint(_ path: CGMutablePath, x: CGFloat, y: CGFloat, node: SKSpriteNode) {
		path.move(to: CGPoint(x: (x * 2) - offset(node, isX: true), y: (y * 2) - offset(node, isX: false)))
	}
	
	func generateFluid() {
		let sprite: SKSpriteNode = SKSpriteNode(imageNamed: "ball")
		sprite.position = CGPoint(x: Float.range(self.frame.midX - 40, max: self.frame.midX + 40), y: self.frame.maxY)
		sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
		self.addChild(sprite)
		sprite.run(SKAction.sequence([SKAction.wait(forDuration: 20), SKAction.removeFromParent()]))
    }
}
