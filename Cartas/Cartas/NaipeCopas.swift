//
//  NaipeCopas.swift
//  Cartas
//
//  Created by Marcio Barros on 27/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

class NaipeCopas: UIView {
	
	override func drawRect(rect: CGRect)
	{
		let centerSquareSide = min(bounds.size.width, bounds.size.height)
		let centerSquareX = (bounds.size.width - centerSquareSide) / 2
		let centerSquareY = (bounds.size.height - centerSquareSide) / 2

		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(centerSquareX + centerSquareSide / 2, centerSquareY + centerSquareSide))
		
		path.addCurveToPoint(CGPointMake(centerSquareX, centerSquareY + centerSquareSide / 4),
			controlPoint1: CGPointMake(centerSquareX + centerSquareSide / 2, centerSquareY + centerSquareSide * 3 / 4),
			controlPoint2: CGPointMake(centerSquareX, centerSquareY + centerSquareSide / 2))
		
		path.addArcWithCenter(CGPointMake(centerSquareX + centerSquareSide / 4, centerSquareY + centerSquareSide / 4),
			radius: centerSquareSide / 4,
			startAngle: CGFloat(M_PI),
			endAngle: 0,
			clockwise: true)
		
		path.addArcWithCenter(CGPointMake(centerSquareX + centerSquareSide * 3 / 4, centerSquareY + centerSquareSide / 4),
			radius: centerSquareSide / 4,
			startAngle: CGFloat(M_PI),
			endAngle: 0,
			clockwise: true)
		
		path.addCurveToPoint(CGPointMake(centerSquareX + centerSquareSide / 2, centerSquareY + centerSquareSide),
			controlPoint1: CGPointMake(centerSquareX + centerSquareSide, centerSquareY + centerSquareSide / 2),
			controlPoint2: CGPointMake(centerSquareX + centerSquareSide / 2, centerSquareY + centerSquareSide * 3 / 4))
		
		path.closePath()
		UIColor.redColor().set()
		path.fill()
	}
}