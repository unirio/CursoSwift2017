//
//  NaipeOuro.swift
//  Cartas
//
//  Created by Marcio Barros on 27/12/16.
//  Copyright © 2016 br.unirio.ios. All rights reserved.
//

import UIKit

@IBDesignable class NaipeOuro: UIView {
	
	override func draw(_ rect: CGRect)
	{
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: bounds.minX, y: center.y))
		path.addLine(to: CGPoint(x: center.x, y: bounds.minY))
		path.addLine(to: CGPoint(x: bounds.maxX, y: center.y))
		path.addLine(to: CGPoint(x: center.x, y: bounds.maxY))
		path.addLine(to: CGPoint(x: bounds.minX, y: center.y))

		UIColor.red.set()
		path.fill()
	}
}
