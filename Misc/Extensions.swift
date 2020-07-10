//
//  Extensions.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 30/03/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import Foundation

//MARK: textField

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

extension UIView {
    
    func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
       
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
        
    }
    
    func slideInFromBottom(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        
        // Create a CATransition animation
        let slideInFromBotttomTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromBotttomTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromBotttomTransition.type = CATransitionType.push
        slideInFromBotttomTransition.subtype = CATransitionSubtype.fromTop
        slideInFromBotttomTransition.duration = duration
        slideInFromBotttomTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromBotttomTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromBotttomTransition, forKey: "slideInFromBottomTransition")
        
    }
    
    func slideInFromRight(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
         
         // Create a CATransition animation
         let slideInFromRightTransition = CATransition()
         
         // Set its callback delegate to the completionDelegate that was provided (if any)
         if let delegate: AnyObject = completionDelegate {
             slideInFromRightTransition.delegate = delegate as! CAAnimationDelegate
         }
         
         // Customize the animation's properties
         slideInFromRightTransition.type = CATransitionType.push
         slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
         slideInFromRightTransition.duration = duration
         slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
         slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
         
         // Add the animation to the View's layer
         self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
         
     }
    
    func slideInFromTop(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        
        // Create a CATransition animation
        let slideInFromTopTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromTopTransition.delegate = delegate as! CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromTopTransition.type = CATransitionType.push
        slideInFromTopTransition.subtype = CATransitionSubtype.fromBottom
        slideInFromTopTransition.duration = duration
        slideInFromTopTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromTopTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromTopTransition, forKey: "slideInFromTopTransition")
        
    }
    
}


// MARK: ******

//MARK: UIView

extension UIView {
  
  
  // This extension will add an easy way to give a shadow. Just call your outlet and add the function name.


  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

//MARK: *******
