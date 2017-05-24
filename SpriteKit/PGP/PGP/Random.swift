//
//  Random.swift
//  PGP
//
//  Created by Marcio Barros on 1/28/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

extension CGFloat {
	
	// Returns a uniform [0, 1] random number
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
}