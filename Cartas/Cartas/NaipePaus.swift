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
	
	override func draw(_ rect: CGRect)
	{
		let centerSquareSide = min(bounds.size.width, bounds.size.height)
		let centerSquareX = (bounds.size.width - centerSquareSide) / 2
		let centerSquareY = (bounds.size.height - centerSquareSide) / 2
		
		let clubX = centerSquareX + centerSquareSide * HEART_REDUCTION
		let clubY = centerSquareY + centerSquareSide * HEART_REDUCTION
		let clubWidth = centerSquareSide * (1 - 2 * HEART_REDUCTION)
		let clubHeight = centerSquareSide * (1 - 3 * HEART_REDUCTION)
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: clubX + clubWidth / 2, y: clubY))
		
		path.addArc(withCenter: CGPoint(x: clubX + clubWidth / 2, y: clubY + clubHeight / 4),
			radius: clubWidth / 4,
			startAngle: -CGFloat(M_PI) / 2,
			endAngle: CGFloat(M_PI) / 2 * 10 / 8,
			clockwise: false)
		
		path.addArc(withCenter: CGPoint(x: clubX + clubWidth / 4, y: clubY + clubHeight * 3 / 4),
			radius: clubWidth / 4,
			startAngle: -CGFloat(M_PI) / 2 * 6 / 8,
			endAngle: CGFloat(M_PI) / 6.0,
			clockwise: false)
		
		let cossine = cos(CGFloat(M_PI) / 6.0)
		let leftLegX = clubX + clubWidth / 4 + clubWidth / 4 * cossine
		let rightLegX = clubX + clubWidth * 3 / 4 - clubWidth / 4 * cossine
		
		path.addLine(to: CGPoint(x: leftLegX, y: clubY + clubHeight))
		
		path.addCurve(to: CGPoint(x: clubX + clubWidth / 4, y: centerSquareY + centerSquareSide),
			controlPoint1: CGPoint(x: leftLegX, y: centerSquareY + centerSquareSide),
			controlPoint2: CGPoint(x: clubX + clubWidth / 4, y: centerSquareY + centerSquareSide))
		
		path.addLine(to: CGPoint(x: clubX + clubWidth * 3 / 4, y: centerSquareY + centerSquareSide))
		
		path.addCurve(to: CGPoint(x: rightLegX, y: clubY + clubHeight),
			controlPoint1: CGPoint(x: clubX + clubWidth * 3 / 4, y: centerSquareY + centerSquareSide),
			controlPoint2: CGPoint(x: rightLegX, y: centerSquareY + centerSquareSide))
		
		path.addLine(to: CGPoint(x: rightLegX, y: clubY + clubHeight))
		
		path.addArc(withCenter: CGPoint(x: clubX + clubWidth * 3 / 4, y: clubY + clubHeight * 3 / 4),
			radius: clubWidth / 4,
			startAngle: CGFloat(M_PI) * 5.0 / 6.0,
			endAngle: -CGFloat(M_PI) / 2 * 10 / 8,
			clockwise: false)
				
		path.addArc(withCenter: CGPoint(x: clubX + clubWidth / 2, y: clubY + clubHeight / 4),
			radius: clubWidth / 4,
			startAngle: -CGFloat(M_PI) / 2 * 10 / 8 + CGFloat(M_PI),
			endAngle: -CGFloat(M_PI) / 2,
			clockwise: false)

		path.close()
		UIColor.black.set()
		path.fill()
	}
}
