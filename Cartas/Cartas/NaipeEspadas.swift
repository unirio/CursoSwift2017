//
//  NaipeEspadas.swift
//  Cartas
//
//  Created by Marcio Barros on 29/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

class NaipeEspadas: UIView {
	
	private let HEART_REDUCTION : CGFloat = 0.1
	
	override func drawRect(rect: CGRect)
	{
		let centerSquareSide = min(bounds.size.width, bounds.size.height)
		let centerSquareX = (bounds.size.width - centerSquareSide) / 2
		let centerSquareY = (bounds.size.height - centerSquareSide) / 2
		
		let heartX = centerSquareX + centerSquareSide * HEART_REDUCTION
		let heartY = centerSquareY
		let heartWidth = centerSquareSide * (1 - 2 * HEART_REDUCTION)
		let heartHeight = centerSquareSide * (1 - HEART_REDUCTION)
		
		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(heartX + heartWidth / 2, heartY))
		
		path.addCurveToPoint(CGPointMake(heartX, heartY + heartHeight * 3 / 4),
			controlPoint1: CGPointMake(heartX + heartWidth / 2, heartY + heartHeight / 4),
			controlPoint2: CGPointMake(heartX, heartY + heartHeight / 2))
		
		path.addArcWithCenter(CGPointMake(heartX + heartWidth / 4, heartY + heartHeight * 3 / 4),
			radius: heartWidth / 4,
			startAngle: CGFloat(M_PI),
			endAngle: CGFloat(M_PI) / 6.0,
			clockwise: false)
		
		let cossine = cos(CGFloat(M_PI) / 6.0)
		let leftLegX = heartX + heartWidth / 4 + heartWidth / 4 * cossine
		let rightLegX = heartX + heartWidth * 3 / 4 - heartWidth / 4 * cossine
		
		path.addLineToPoint(CGPointMake(leftLegX, heartY + heartHeight))
		
		path.addCurveToPoint(CGPointMake(heartX + heartWidth / 4, centerSquareY + centerSquareSide),
			controlPoint1: CGPointMake(leftLegX, centerSquareY + centerSquareSide),
			controlPoint2: CGPointMake(heartX + heartWidth / 4, centerSquareY + centerSquareSide))
		
		path.addLineToPoint(CGPointMake(heartX + heartWidth * 3 / 4, centerSquareY + centerSquareSide))
		
		path.addCurveToPoint(CGPointMake(rightLegX, heartY + heartHeight),
			controlPoint1: CGPointMake(heartX + heartWidth * 3 / 4, centerSquareY + centerSquareSide),
			controlPoint2: CGPointMake(rightLegX, centerSquareY + centerSquareSide))
		
		path.addLineToPoint(CGPointMake(rightLegX, heartY + heartHeight))
		
		path.addArcWithCenter(CGPointMake(heartX + heartWidth * 3 / 4, heartY + heartHeight * 3 / 4),
			radius: heartWidth / 4,
			startAngle: CGFloat(M_PI) * 5.0 / 6.0,
			endAngle: 0.0,
			clockwise: false)
		
		path.addCurveToPoint(CGPointMake(heartX + heartWidth / 2, heartY),
			controlPoint1: CGPointMake(heartX + heartWidth, heartY + heartHeight / 2),
			controlPoint2: CGPointMake(heartX + heartWidth / 2, heartY + heartHeight / 4))
		
		path.closePath()
		UIColor.blackColor().set()
		path.fill()
	}
}