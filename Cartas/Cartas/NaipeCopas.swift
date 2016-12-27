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
		let minimo = min(bounds.size.width, bounds.size.height)
		
		let scaledWidth = minimo
		let scaledXValue = (bounds.size.width - minimo) / 2
		let scaledHeight = minimo
		let scaledYValue = (bounds.size.height - minimo) / 2
		let scaledRect = CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)

		let figura = UIBezierPath()
		figura.moveToPoint(CGPointMake(scaledRect.origin.x + scaledRect.size.width/2, scaledRect.origin.y + scaledRect.size.height))
		
		figura.addCurveToPoint(CGPointMake(scaledRect.origin.x, scaledRect.origin.y + (scaledRect.size.height/4)),
			controlPoint1: CGPointMake(scaledRect.origin.x + (scaledRect.size.width/2), scaledRect.origin.y + (scaledRect.size.height*3/4)) ,
			controlPoint2: CGPointMake(scaledRect.origin.x, scaledRect.origin.y + (scaledRect.size.height/2)))
		
		figura.addArcWithCenter(CGPointMake(scaledRect.origin.x + (scaledRect.size.width/4),scaledRect.origin.y + (scaledRect.size.height/4)),
			radius: (scaledRect.size.width / 4),
			startAngle: CGFloat(M_PI),
			endAngle: 0,
			clockwise: true)
		
		figura.addArcWithCenter(CGPointMake(scaledRect.origin.x + (scaledRect.size.width * 3/4),scaledRect.origin.y + (scaledRect.size.height/4)),
			radius: (scaledRect.size.width / 4),
			startAngle: CGFloat(M_PI),
			endAngle: 0,
			clockwise: true)
		
		figura.addCurveToPoint(CGPointMake(scaledRect.origin.x + scaledRect.size.width/2, scaledRect.origin.y + scaledRect.size.height),
			controlPoint1: CGPointMake(scaledRect.origin.x + scaledRect.size.width, scaledRect.origin.y + (scaledRect.size.height/2)),
			controlPoint2: CGPointMake(scaledRect.origin.x + (scaledRect.size.width/2), scaledRect.origin.y + (scaledRect.size.height*3/4)) )
		
		figura.closePath()
		UIColor.redColor().set()
		figura.fill()
	}
}