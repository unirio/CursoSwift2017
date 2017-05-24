//
//  GameScene.swift
//  MenuAcies
//
//  Created by Marcio Barros on 4/9/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

//
// Cena principal do jogo
//
class GameScene: SKScene {
	var starship : SKSpriteNode!
	var lastMenuPosition = 0

	/*
	 * Cria os componentes do jogo
	 */
    override func didMove(to view: SKView) {
		createLabel("rotate_right")
		createLabel("rotate_left")
		createLabel("move_right")
		createLabel("move_left")
		createLabel("move_up")
		createLabel("move_down")
		createLabel("fade_out")
		createLabel("fade_in")
		createLabel("grow_x")
		createLabel("grow_y")
		createLabel("reduce_x")
		createLabel("reduce_y")
		createStarship()
    }
	
	/*
	 * Cria um item de menu do jogo
	 */
	func createLabel(_ title: String) {
        let myLabel = SKLabelNode(fontNamed: "AvenirNext")
        myLabel.text = title
		myLabel.name = title
        myLabel.fontSize = 20
		myLabel.verticalAlignmentMode = .top
		myLabel.horizontalAlignmentMode = .left
		
		let yPosition = self.frame.maxY - CGFloat(40 * lastMenuPosition)
        myLabel.position = CGPoint(x: self.frame.minX, y: yPosition)
		lastMenuPosition += 1;
		
		self.addChild(myLabel)
	}
	
	/*
	 * Cria a espaço-nave no centro da tela
	 */
	func createStarship() {
		starship = SKSpriteNode(imageNamed: "Spaceship")
		starship.position = CGPoint(x: frame.midX, y: frame.midY)
		starship.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		starship.xScale = 0.5
		starship.yScale = 0.5
		self.addChild(starship)
	}
	
	/*
	 * Identifica e executa os comandos
	 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let touchLocation = touch.location(in: self)
			let touchedNode = self.atPoint(touchLocation)
			
			if let name = touchedNode.name {
				executeCommand(name)
			}
        }
    }
	
	/*
	 * Executa um comando sobre a espaço-nave
	 */
	func executeCommand(_ name: String) {
		switch name {
			case "rotate_right":
				starship.run(SKAction.rotate(byAngle: CGFloat(M_PI_2), duration: 3.0))

			case "rotate_left":
				starship.run(SKAction.rotate(byAngle: CGFloat(-M_PI_2), duration: 3.0))

			case "move_right":
				starship.run(SKAction.moveBy(x: 50.0, y: 0.0, duration: 3.0))

			case "move_left":
				starship.run(SKAction.moveBy(x: -50.0, y: 0.0, duration: 3.0))

			case "move_up":
				starship.run(SKAction.moveBy(x: 0.0, y: 25.0, duration: 3.0))

			case "move_down":
				starship.run(SKAction.moveBy(x: 0.0, y: -25.0, duration: 3.0))

			case "fade_out":
				starship.run(SKAction.fadeAlpha(by: -0.25, duration: 3.0))

			case "fade_in":
				starship.run(SKAction.fadeAlpha(by: +0.25, duration: 3.0))

			case "grow_x":
				starship.run(SKAction.scaleX(by: 1.5, y: 1.0, duration: 3.0))

			case "grow_y":
				starship.run(SKAction.scaleX(by: 1.0, y: 1.5, duration: 3.0))

			case "reduce_x":
				starship.run(SKAction.scaleX(by: 0.5, y: 1.0, duration: 3.0))

			case "reduce_y":
				starship.run(SKAction.scaleX(by: 1.0, y: 0.5, duration: 3.0))
			
			default:
				break
		}
	}
}
