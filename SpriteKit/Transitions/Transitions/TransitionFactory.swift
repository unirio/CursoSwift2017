//
//  TransitionFactory.swift
//  Transitions
//
//  Created by Marcio Barros on 3/19/15.
//  Copyright (c) 2015 UNIRIO. All rights reserved.
//

import SpriteKit

class TransitionFactory {

    class func createForwardTransition() -> SKTransition {
		return SKTransition.push(with: .right, duration: 1)
		//return SKTransition.revealWithDirection(.Right, duration: 1)
		//return SKTransition.flipHorizontalWithDuration(1)
		//return SKTransition.fadeWithDuration(1)
		//return SKTransition.doorsOpenHorizontalWithDuration(1)
		//return SKTransition.doorsCloseHorizontalWithDuration(1)
		//return SKTransition.crossFadeWithDuration(2)
	}

    class func createBackwardTransition() -> SKTransition {
		//return SKTransition.pushWithDirection(.Left, duration: 1)
		//return SKTransition.revealWithDirection(.Left, duration: 1)
		//return SKTransition.flipVerticalWithDuration(1)
		//return SKTransition.fadeWithColor(UIColor.redColor(), duration: 1)
		//return SKTransition.doorsOpenVerticalWithDuration(1)
		//return SKTransition.doorsCloseVerticalWithDuration(1)
		return SKTransition.doorway(withDuration: 1)
	}
}
