//
//  StarfieldNode.swift
//  PGP
//
//  Created by Marcio Barros on 1/28/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import Foundation
import SpriteKit

//
// Custom layer that presents a parallax scrolling starfield
//
class ParallaxStarfieldNode : SKShapeNode {
	var starfields : [StarfieldNode] = []
	var horizontalGravity = CGFloat(0.0)
	var verticalGravity = CGFloat(1.0)
	var size: CGSize!
	
	// Required standard initializer for nodes
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// Initializes the node to a given size
	required init(size: CGSize) {
		super.init()
		self.size = size
	}
	
	// Adds a starfield to the layer
	func addStarfield(_ starCount: Int, color: UIColor, speed: CGFloat) {
		let starfield = Starfield(width: size.width, height: size.height, starCount: starCount, color: color, speed: speed)
		let starfieldNode = StarfieldNode(size: size, starfield: starfield)
		starfields += [starfieldNode]
		addChild(starfieldNode)
	}
	
	// Update the position of stars in all starfields
	func update() {
		for field in starfields {
			field.move(horizontalGravity, dy: -verticalGravity)
			field.draw()
		}
	}
}

//
// Custom layer that presents a parallax scrolling starfield
//
class StarfieldNode : SKShapeNode {
	var starfield : Starfield!
	var size: CGSize!
	
	// Required standard initializer for nodes
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// Initializes the node to a given size and starfield
	required init(size: CGSize, starfield: Starfield) {
		super.init()
		self.size = size
		self.starfield = starfield
	}
	
	// Draws the stars
	func draw() {
		self.strokeColor = starfield.color
		self.path = starfield.getPath()
	}
	
	// Update the position of stars
	func move(_ dx: CGFloat, dy: CGFloat) {
		starfield.move(dx, dy: dy, width: size.width, height: size.height)
		draw()
	}
}

//
// Class that represents a starfield
//
class Starfield {
	var speed = CGFloat(0.0)
	var color : UIColor!
	var stars : [Star] = []

	// Initializes a starfield
	init(width: CGFloat, height: CGFloat, starCount: Int, color: UIColor, speed: CGFloat) {
		self.color = color
		self.speed = speed

		for _ in 0 ..< starCount {
			self.stars += [Star(width: width, height: height)]
		}
	}

	// Moves the starfield
	func move(_ dx: CGFloat, dy: CGFloat, width: CGFloat, height: CGFloat) {
		for star in stars {
			star.move(dx * speed, dy: dy * speed, width: width, height: height)
		}
	}
	
	// Creates a path for the starfield
	func getPath() -> CGMutablePath {
		let path = CGMutablePath()
		
		for star in stars {
			path.addRect(CGRect(x: star.x, y: star.y, width: 0.5, height: 0.5))
		}

		return path
	}
}

//
// Class that represents a star in a starfield
//
class Star {
	var x = CGFloat(0.0)
	var y = CGFloat(0.0)
	
	// Initializes the star in a given position
	init(x: CGFloat, y: CGFloat) {
		self.x = x
		self.y = y
	}
	
	// Initializes the star in a random position
	init(width: CGFloat, height: CGFloat) {
		self.x = width * CGFloat(Float(arc4random()) / Float(UINT32_MAX))
		self.y = height * CGFloat(Float(arc4random()) / Float(UINT32_MAX))
	}

	// Moves the star by a certain degree
	func move(_ dx: CGFloat, dy: CGFloat, width: CGFloat, height: CGFloat) {
		x += dx
		y += dy
		
		if x > width {
			x = x - width
		}
		else if x < 0.0 {
			x = width - x
		}
		
		if y > height {
			y = y - height
		}
		else if y < 0.0 {
			y = height - y
		}
	}
}
