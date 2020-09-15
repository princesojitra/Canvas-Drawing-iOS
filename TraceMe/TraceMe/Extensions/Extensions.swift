//
//  UIView+Extension.swift
//  TraceMe
//
//  Created by Prince Sojitra on 14/09/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//


import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    
     func round(corners: UIRectCorner, cornerRadius: Double) {
          
          let size = CGSize(width: cornerRadius, height: cornerRadius)
          let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
          let shapeLayer = CAShapeLayer()
          shapeLayer.frame = self.bounds
          shapeLayer.path = bezierPath.cgPath
          self.layer.mask = shapeLayer
      }
    
    @discardableResult
       func pinToSuperViewEdges() -> [NSLayoutConstraint] {
           guard let superview = superview?.safeAreaLayoutGuide else { return [] }
           
           translatesAutoresizingMaskIntoConstraints = false
           
           topAnchor.constraint(equalTo: superview.topAnchor ).isActive = true
           bottomAnchor.constraint(equalTo: superview.bottomAnchor ).isActive = true
           leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
           trailingAnchor.constraint(equalTo: superview.trailingAnchor ).isActive = true
           
           return constraints
       }
    
}




enum AppColor {
    static let Color_Blue = UIColor.init(hex: "2A2F8D")
}

extension UIColor {
    
    convenience init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let red  = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
