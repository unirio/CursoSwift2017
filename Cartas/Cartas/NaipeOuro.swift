//
//  NaipeOuro.swift
//  Cartas
//
//  Created by Marcio Barros on 27/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

class NaipeOuro: UIView {
	
	override func drawRect(rect: CGRect)
	{
		let centro = CGPoint(x: bounds.midX, y: bounds.midY)
		
		let figura = UIBezierPath()
		figura.moveToPoint(CGPoint(x: bounds.minX, y: centro.y))
		figura.addLineToPoint(CGPoint(x: centro.x, y: bounds.minY))
		figura.addLineToPoint(CGPoint(x: bounds.maxX, y: centro.y))
		figura.addLineToPoint(CGPoint(x: centro.x, y: bounds.maxY))
		figura.addLineToPoint(CGPoint(x: bounds.minX, y: centro.y))
//		figura.lineWidth = 1
		UIColor.redColor().set()
//		figura.stroke()
		figura.fill()
	}
}