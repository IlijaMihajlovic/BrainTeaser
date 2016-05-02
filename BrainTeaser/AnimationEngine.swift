//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Jonny B on 3/27/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    // Variables
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]
    
    
    class var offScreenRightPosition: CGPoint {
        
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint{
        
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
  
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int) {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            
            var index = 0
            
            repeat {
                
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
                
            } while (index < self.constraints.count)
            
        }
        
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation!, Bool) -> Void)) {
        
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 8
        moveAnim.springSpeed = 8
        moveAnim.completionBlock = completion
        view.pop_addAnimation(moveAnim, forKey: "moveToPosition")
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
