//
//  Canvas.swift
//  TraceMe
//
//  Created by Prince Sojitra on 14/09/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//


import UIKit

class Canvas: UIView {
    
    // public function
    fileprivate var strokeColor = AppColor.Color_Blue
    fileprivate var strokeWidth: Float = 2
    fileprivate var isShapeDrwan: Bool = false
    fileprivate var imageAnimationXPoint : CGFloat = 0.0
    fileprivate var imageAnimationYPoint : CGFloat = 0.0
    fileprivate var imgVwAnimation : UIImageView?
    fileprivate var totalPointsPath : Int = 0
    fileprivate var path = UIBezierPath()
    
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func startDrawing() {
        self.isUserInteractionEnabled = true
    }
    
    func playAnimation() {
        
        if lines.count > 0 {
            let path = UIBezierPath()
            lines.forEach { (line) in
                for (i, p) in line.points.enumerated() {
                    self.totalPointsPath += line.points.count
                    print("Index",i)
                    print("Point",p)
                    if i == 0 {
                        path.move(to: p)
                        self.imageAnimationXPoint = p.x
                        self.imageAnimationYPoint = p.y
                    } else if i == line.points.count - 1 {
                        path.move(to: p)
                    }
                    else{
                        path.addLine(to: p)
                    }
                }
            }
            path.close()
            
            
            print("total points",self.totalPointsPath)
            
            
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if self.imgVwAnimation != nil {
                    self.imgVwAnimation!.frame = CGRect(x: self.imageAnimationXPoint - 10, y: self.imageAnimationYPoint - 20, width: 35, height: 35)
                    //                print(self.imgVwAnimation)
                }
            }
            
            
            if self.imgVwAnimation == nil {
                
                self.imgVwAnimation = UIImageView(frame: CGRect(x: self.imageAnimationXPoint, y: self.imageAnimationYPoint, width: 35, height: 35))
                
                
            }
            
            imgVwAnimation!.contentMode = .scaleAspectFit
            imgVwAnimation!.image = UIImage(named: "car")
            //            imgVwAnimation!.backgroundColor = UIColor.red
            let robotAnimation = CAKeyframeAnimation(keyPath: "position")
            robotAnimation.path = path.cgPath
            robotAnimation.duration = 15
            robotAnimation.repeatCount = .zero
            robotAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
            self.addSubview(imgVwAnimation!)
            imgVwAnimation!.layer.add(robotAnimation, forKey: "robot")
            CATransaction.commit()
        }
    }
    
    func clear() {
        lines.removeAll()
        self.isShapeDrwan = false
        if self.imgVwAnimation != nil {
            self.imgVwAnimation!.removeFromSuperview()
        }
        setNeedsDisplay()
    }
    
    fileprivate var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.isUserInteractionEnabled = false
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                print("Index",i)
                print("Point",p)
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isShapeDrwan {
            lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isShapeDrwan {
            
            guard let point = touches.first?.location(in: nil) else { return }
            print("Point",point)
            guard var lastLine = lines.popLast() else { return }
            let finalpoint = CGPoint(x: point.x - 70, y: point.y - 30)
            lastLine.points.append(finalpoint)
            lines.append(lastLine)
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isShapeDrwan = true
    }
}
