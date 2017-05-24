//
//  PlayScene.swift
//  PGP
//
//  Created by Marcio Barros on 1/23/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import Foundation
import SpriteKit

class PlayScene: SKScene {
	var globeNode : SKShapeNode!
	var spaceshipNode : SKSpriteNode!
	var niceGodNode : SKSpriteNode!
	var cruelGodNode : SKSpriteNode!
	var preparingToChange = false
	var nextTimeChanged : TimeInterval!
	var startGameTime : TimeInterval!
	var scoreLabel : SKLabelNode!
	var gravityLabel : SKLabelNode!
	var currentRadius = CGFloat(0)
	var gamePaused = false

	/*
	 * Prepare the components of the scene
	 */
    override func didMove(to view: SKView) {
		backgroundColor = UIColor.black
		physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.1)

		let bgImage = SKSpriteNode(imageNamed: "background")
		bgImage.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
		bgImage.zPosition = 0
		self.addChild(bgImage)

		createGlobe(view)
		createNiceGod(view)
		createCruelGod(view)
		createSpaceship(view)
		createDataPanel(view)
    }

	/*
	 * Creates the shape that represents the globe
	 */
	func createGlobe(_ view: SKView) {
		currentRadius = view.bounds.height * 0.45
		globeNode = SKShapeNode(circleOfRadius: currentRadius)
		globeNode.position = CGPoint(x: view.bounds.height * 0.5, y: view.bounds.height * 0.5)
		globeNode.fillColor = UIColor.black
		globeNode.strokeColor = UIColor.white
		globeNode.zPosition = 10
		globeNode.lineWidth = 2.0
		self.addChild(globeNode)
	}

	/*
	 * Creates the sprite for the good god
	 */
	func createNiceGod(_ view: SKView) {
		niceGodNode = SKSpriteNode(imageNamed: "niceGod")
		niceGodNode.position = CGPoint(x: view.bounds.width + 10.0, y: -10.0)
		niceGodNode.anchorPoint = CGPoint(x: 1.0, y: 0.0)
		niceGodNode.zPosition = 10
		self.addChild(niceGodNode)
	}

	/*
	 * Creates the sprite for the cruel gog
	 */
	func createCruelGod(_ view: SKView) {
		cruelGodNode = SKSpriteNode(imageNamed: "cruelGod")
		cruelGodNode.position = CGPoint(x: view.bounds.width, y: 0)
		cruelGodNode.anchorPoint = CGPoint(x: 1.0, y: 0.0)
		cruelGodNode.zPosition = 10
		cruelGodNode.alpha = 0.0
		self.addChild(cruelGodNode)
	}
	
	/*
	 * Creates the sprite and physical manifestation of the ship
	 */
	func createSpaceship(_ view: SKView) {
		spaceshipNode = SKSpriteNode(imageNamed: "Spaceship")
		spaceshipNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		spaceshipNode.position = CGPoint(x: view.bounds.height * 0.5, y: view.bounds.height * 0.5)
		spaceshipNode.setScale(0.05)
		spaceshipNode.zRotation = CGFloat(-Double.pi / 2)
		spaceshipNode.zPosition = 20
		self.addChild(spaceshipNode)
		
		let center = CGPoint(x: spaceshipNode.frame.width * (0.5 - spaceshipNode.anchorPoint.x), y: spaceshipNode.frame.height * (0.5 - spaceshipNode.anchorPoint.y))
		let borderBody = SKPhysicsBody(circleOfRadius: spaceshipNode.frame.width / 2, center: center)
		spaceshipNode.physicsBody = borderBody
	}
	
	/*
	 * Creates a data panel presenting the gravity
	 */
	func createDataPanel(_ view: SKView) {
		let scoreTitleLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		scoreTitleLabel.text = "Score:"
		scoreTitleLabel.fontColor = UIColor.yellow
		scoreTitleLabel.fontSize = 14
		scoreTitleLabel.position = CGPoint(x: view.bounds.width * 0.7, y: view.bounds.height * 0.9)
		addChild(scoreTitleLabel)
		
		scoreLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		scoreLabel.text = "10000"
		scoreLabel.fontColor = UIColor.white
		scoreLabel.fontSize = 10
		scoreLabel.position = CGPoint(x: view.bounds.width * 0.7, y: view.bounds.height * 0.85)
		addChild(scoreLabel)

		let gravityTitleLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		gravityTitleLabel.text = "Gravity:"
		gravityTitleLabel.fontColor = UIColor.yellow
		gravityTitleLabel.fontSize = 14
		gravityTitleLabel.position = CGPoint(x: view.bounds.width * 0.85, y: view.bounds.height * 0.9)
		addChild(gravityTitleLabel)
		
		gravityLabel = SKLabelNode(fontNamed: "Arial-BoldMT")
		gravityLabel.text = "(10%, 50%)"
		gravityLabel.fontColor = UIColor.white
		gravityLabel.fontSize = 10
		gravityLabel.position = CGPoint(x: view.bounds.width * 0.85, y: view.bounds.height * 0.85)
		addChild(gravityLabel)
		
		updateGravityLabels()
	}
	
	/*
	 * Applies an impulse to the ship according to its position and a touch
	 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in: self)
			var verticalImpulse = CGFloat(0.0)
			var horizontalImpulse = CGFloat(0.0)

			if (location.y < spaceshipNode.position.y - spaceshipNode.size.height/2) {
				verticalImpulse = -1.0
			}
			else if (location.y > spaceshipNode.position.y + spaceshipNode.size.height/2) {
				verticalImpulse = 1.0
			}

			if (location.x < spaceshipNode.position.x + spaceshipNode.size.width / 2) {
				horizontalImpulse = -1.0
			}
			else if (location.x > spaceshipNode.position.x - spaceshipNode.size.width / 2) {
				horizontalImpulse = 1.0
			}
		
			spaceshipNode.zRotation = -horizontalImpulse * CGFloat(M_PI) * (2.0 - verticalImpulse) / 4
			spaceshipNode.physicsBody?.applyImpulse(CGVector(dx: horizontalImpulse, dy: verticalImpulse))
        }
    }
	
	/*
	 * Shows the bad guy, hiding the good one
	 */
	func showCruelGod() {
		cruelGodNode.alpha = 1.0
		niceGodNode.alpha = 0.0
	}
	
	/*
	 * Shows the nice guy, hiding the cruel one
	 */
	func showNiceGod() {
		cruelGodNode.alpha = 0.0
		niceGodNode.alpha = 1.0
	}

	/*
	 * Updates gravity in the data panel
	 */
	func updateGravityLabels() {
		let dx = physicsWorld.gravity.dx
		let dy = physicsWorld.gravity.dy
		gravityLabel.text = NSString(format: "%.0f%%, %.0f%%", Double(dx) * 100, Double(dy) * 100) as String
	}
	
	/*
	 * Updates game state each time a frame is drawn
	 */
	override func update(_ currentTime: TimeInterval) {
		if gamePaused {
			return
		}
		
		if nextTimeChanged == nil {
			nextTimeChanged = currentTime + 10.0 + Double(arc4random_uniform(15))
		}
		
		if startGameTime == nil {
			startGameTime = currentTime
		}
		
		let score = currentTime - startGameTime
		scoreLabel.text = NSString(format: "%.0f", score) as String
		
		updateGlobeRadius(score)
		checkForCollision()
		
		if currentTime > nextTimeChanged {
			nextTimeChanged = currentTime + 10.0 + Double(arc4random_uniform(15))
			randomizeGravity()
		}
	}
	
	/*
	 * Update the radius of the globe
	 */
	func updateGlobeRadius(_ score: Double) {
		let newRadius = view!.bounds.height * 0.45 * (200.0 - CGFloat(score)) / 200.0
		
		if currentRadius - newRadius > 10 {
			globeNode.removeFromParent()
			currentRadius = newRadius
			globeNode = SKShapeNode(circleOfRadius: currentRadius)
			globeNode.position = CGPoint(x: view!.bounds.height * 0.5, y: view!.bounds.height * 0.5)
			globeNode.fillColor = UIColor.black
			globeNode.strokeColor = UIColor.white
			globeNode.zPosition = 10
			globeNode.lineWidth = 2.0
			self.addChild(globeNode)
		}
	}
	
	/*
	 * Checks if the spaceship has collided with the globe
	 */
	func checkForCollision() {
		let distance = sqrt(pow(view!.bounds.height * 0.5 - spaceshipNode.position.x, 2) + pow(view!.bounds.height * 0.5 - spaceshipNode.position.y, 2))
		
		if (distance > currentRadius - 5) {
			die()
		}
	}
	
	/*
	 * Take actions when the spaceship collided
	 */
    func die() {
		gamePaused = true
		spaceshipNode.removeAllActions()
		spaceshipNode.physicsBody?.isDynamic = false
		
		spaceshipNode.run(SKAction.fadeOut(withDuration: 1))
		run(SKAction.playSoundFileNamed("button-10.wav", waitForCompletion: true))
		
		let alert = UIAlertController(title: "Game Over", message: "", preferredStyle: UIAlertControllerStyle.alert)
		
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { _ in
			self.restart()
		})
			
		self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
	}
	
	/*
	 * Randomizes the direction and intensity of gravity in space
	 */
	func randomizeGravity() {
		let this = self
		showCruelGod()
		
		let verticalGravity = CGFloat.random() - 0.5
		let horizontalGravity = CGFloat.random() - 0.5
		physicsWorld.gravity = CGVector(dx: horizontalGravity, dy: verticalGravity)
		updateGravityLabels()

		let waitAction = SKAction.wait(forDuration: CFTimeInterval(2.0))
		
		spaceshipNode.run(waitAction, completion: {
			this.showNiceGod()
		});
	}

	/*
	 * Restarts the game
	 */
    func restart() {
		spaceshipNode.position = CGPoint(x: view!.bounds.height * 0.5, y: view!.bounds.height * 0.5)
		nextTimeChanged = nil
		startGameTime = nil
		globeNode.removeFromParent()
		createGlobe(self.view!)
		spaceshipNode.alpha = 1.0
		spaceshipNode.physicsBody?.isDynamic = true
		gamePaused = false
	}
}
