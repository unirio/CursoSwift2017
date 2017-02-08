//
//  NaipeCopas.swift
//  Cartas
//
//  Created by Marcio Barros on 27/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

@IBDesignable class NaipeCopas: UIView {
	
	override func draw(_ rect: CGRect)
	{
		let centerSquareSide = min(bounds.size.width, bounds.size.height)
		let centerSquareX = (bounds.size.width - centerSquareSide) / 2
		let centerSquareY = (bounds.size.height - centerSquareSide) / 2

		let path = UIBezierPath()
		path.move(to: CGPoint(x: centerSquareX + centerSquareSide / 2, y: centerSquareY + centerSquareSide))
		
		path.addCurve(to: CGPoint(x: centerSquareX, y: centerSquareY + centerSquareSide / 4),
			controlPoint1: CGPoint(x: centerSquareX + centerSquareSide / 2, y: centerSquareY + centerSquareSide * 3 / 4),
			controlPoint2: CGPoint(x: centerSquareX, y: centerSquareY + centerSquareSide / 2))
		
		path.addArc(withCenter: CGPoint(x: centerSquareX + centerSquareSide / 4, y: centerSquareY + centerSquareSide / 4),
			radius: centerSquareSide / 4,
			startAngle: CGFloat(M_PI),
			endAngle: 0,
			clockwise: true)
		
		path.addArc(withCenter: CGPoint(x: centerSquareX + centerSquareSide * 3 / 4, y: centerSquareY + centerSquareSide / 4),
			radius: centerSquareSide / 4,
			startAngle: CGFloat(M_PI),
			endAngle: 0,
			clockwise: true)
		
		path.addCurve(to: CGPoint(x: centerSquareX + centerSquareSide / 2, y: centerSquareY + centerSquareSide),
			controlPoint1: CGPoint(x: centerSquareX + centerSquareSide, y: centerSquareY + centerSquareSide / 2),
			controlPoint2: CGPoint(x: centerSquareX + centerSquareSide / 2, y: centerSquareY + centerSquareSide * 3 / 4))
		
		path.close()
		UIColor.red.set()
		path.fill()
	}
}
