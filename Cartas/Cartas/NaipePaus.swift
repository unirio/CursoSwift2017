//
//  NaipePaus.swift
//  Cartas
//
//  Created by Marcio Barros on 29/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class NaipePaus: UIView {
	
	private let HEART_REDUCTION : CGFloat = 0.1
	
	override func drawRect(rect: CGRect)
	{
		let centerSquareSide = min(bounds.size.width, bounds.size.height)
		let centerSquareX = (bounds.size.width - centerSquareSide) / 2
		let centerSquareY = (bounds.size.height - centerSquareSide) / 2
		
		let clubX = centerSquareX + centerSquareSide * HEART_REDUCTION
		let clubY = centerSquareY + centerSquareSide * HEART_REDUCTION
		let clubWidth = centerSquareSide * (1 - 2 * HEART_REDUCTION)
		let clubHeight = centerSquareSide * (1 - 3 * HEART_REDUCTION)
		
		let path = UIBezierPath()
		path.moveToPoint(CGPointMake(clubX + clubWidth / 2, clubY))
		
		path.addArcWithCenter(CGPointMake(clubX + clubWidth / 2, clubY + clubHeight / 4),
			radius: clubWidth / 4,
			startAngle: -CGFloat(M_PI) / 2,
			endAngle: CGFloat(M_PI) / 2 * 10 / 8,
			clockwise: false)
		
		path.addArcWithCenter(CGPointMake(clubX + clubWidth / 4, clubY + clubHeight * 3 / 4),
			radius: clubWidth / 4,
			startAngle: -CGFloat(M_PI) / 2 * 6 / 8,
			endAngle: CGFloat(M_PI) / 6.0,
			clockwise: false)
		
		let cossine = cos(CGFloat(M_PI) / 6.0)
		let leftLegX = clubX + clubWidth / 4 + clubWidth / 4 * cossine
		let rightLegX = clubX + clubWidth * 3 / 4 - clubWidth / 4 * cossine
		
		path.addLineToPoint(CGPointMake(leftLegX, clubY + clubHeight))
		
		path.addCurveToPoint(CGPointMake(clubX + clubWidth / 4, centerSquareY + centerSquareSide),
			controlPoint1: CGPointMake(leftLegX, centerSquareY + centerSquareSide),
			controlPoint2: CGPointMake(clubX + clubWidth / 4, centerSquareY + centerSquareSide))
		
		path.addLineToPoint(CGPointMake(clubX + clubWidth * 3 / 4, centerSquareY + centerSquareSide))
		
		path.addCurveToPoint(CGPointMake(rightLegX, clubY + clubHeight),
			controlPoint1: CGPointMake(clubX + clubWidth * 3 / 4, centerSquareY + centerSquareSide),
			controlPoint2: CGPointMake(rightLegX, centerSquareY + centerSquareSide))
		
		path.addLineToPoint(CGPointMake(rightLegX, clubY + clubHeight))
		
		path.addArcWithCenter(CGPointMake(clubX + clubWidth * 3 / 4, clubY + clubHeight * 3 / 4),
			radius: clubWidth / 4,
			startAngle: CGFloat(M_PI) * 5.0 / 6.0,
			endAngle: -CGFloat(M_PI) / 2 * 10 / 8,
			clockwise: false)
				
		path.addArcWithCenter(CGPointMake(clubX + clubWidth / 2, clubY + clubHeight / 4),
			radius: clubWidth / 4,
			startAngle: -CGFloat(M_PI) / 2 * 10 / 8 + CGFloat(M_PI),
			endAngle: -CGFloat(M_PI) / 2,
			clockwise: false)

		path.closePath()
		UIColor.blackColor().set()
		path.fill()
	}
}