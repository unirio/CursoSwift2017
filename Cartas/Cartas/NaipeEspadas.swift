//
//  NaipeEspadas.swift
//  Cartas
//
//  Created by Marcio Barros on 29/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

@IBDesignable class NaipeEspadas: UIView {
	
	private let HEART_REDUCTION : CGFloat = 0.1
	
	override func draw(_ rect: CGRect)
	{
		let centerSquareSide = min(bounds.size.width, bounds.size.height)
		let centerSquareX = (bounds.size.width - centerSquareSide) / 2
		let centerSquareY = (bounds.size.height - centerSquareSide) / 2
		
		let heartX = centerSquareX + centerSquareSide * HEART_REDUCTION
		let heartY = centerSquareY
		let heartWidth = centerSquareSide * (1 - 2 * HEART_REDUCTION)
		let heartHeight = centerSquareSide * (1 - HEART_REDUCTION)
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: heartX + heartWidth / 2, y: heartY))
		
		path.addCurve(to: CGPoint(x: heartX, y: heartY + heartHeight * 3 / 4),
			controlPoint1: CGPoint(x: heartX + heartWidth / 2, y: heartY + heartHeight / 4),
			controlPoint2: CGPoint(x: heartX, y: heartY + heartHeight / 2))
		
		path.addArc(withCenter: CGPoint(x: heartX + heartWidth / 4, y: heartY + heartHeight * 3 / 4),
			radius: heartWidth / 4,
			startAngle: CGFloat(M_PI),
			endAngle: CGFloat(M_PI) / 6.0,
			clockwise: false)
		
		let cossine = cos(CGFloat(M_PI) / 6.0)
		let leftLegX = heartX + heartWidth / 4 + heartWidth / 4 * cossine
		let rightLegX = heartX + heartWidth * 3 / 4 - heartWidth / 4 * cossine
		
		path.addLine(to: CGPoint(x: leftLegX, y: heartY + heartHeight))
		
		path.addCurve(to: CGPoint(x: heartX + heartWidth / 4, y: centerSquareY + centerSquareSide),
			controlPoint1: CGPoint(x: leftLegX, y: centerSquareY + centerSquareSide),
			controlPoint2: CGPoint(x: heartX + heartWidth / 4, y: centerSquareY + centerSquareSide))
		
		path.addLine(to: CGPoint(x: heartX + heartWidth * 3 / 4, y: centerSquareY + centerSquareSide))
		
		path.addCurve(to: CGPoint(x: rightLegX, y: heartY + heartHeight),
			controlPoint1: CGPoint(x: heartX + heartWidth * 3 / 4, y: centerSquareY + centerSquareSide),
			controlPoint2: CGPoint(x: rightLegX, y: centerSquareY + centerSquareSide))
		
		path.addLine(to: CGPoint(x: rightLegX, y: heartY + heartHeight))
		
		path.addArc(withCenter: CGPoint(x: heartX + heartWidth * 3 / 4, y: heartY + heartHeight * 3 / 4),
			radius: heartWidth / 4,
			startAngle: CGFloat(M_PI) * 5.0 / 6.0,
			endAngle: 0.0,
			clockwise: false)
		
		path.addCurve(to: CGPoint(x: heartX + heartWidth / 2, y: heartY),
			controlPoint1: CGPoint(x: heartX + heartWidth, y: heartY + heartHeight / 2),
			controlPoint2: CGPoint(x: heartX + heartWidth / 2, y: heartY + heartHeight / 4))
		
		path.close()
		UIColor.black.set()
		path.fill()
	}
}
