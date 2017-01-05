//
//  NaipeOuro.swift
//  Cartas
//
//  Created by Marcio Barros on 27/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

@IBDesignable class NaipeOuro: UIView {
	
	override func drawRect(rect: CGRect)
	{
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		
		let path = UIBezierPath()
		path.moveToPoint(CGPoint(x: bounds.minX, y: center.y))
		path.addLineToPoint(CGPoint(x: center.x, y: bounds.minY))
		path.addLineToPoint(CGPoint(x: bounds.maxX, y: center.y))
		path.addLineToPoint(CGPoint(x: center.x, y: bounds.maxY))
		path.addLineToPoint(CGPoint(x: bounds.minX, y: center.y))

		UIColor.redColor().set()
		path.fill()
	}
}