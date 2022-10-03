//
//  Circle.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 9/30/22.
//

import UIKit

class Circle: Shape{
    
    var path: UIBezierPath
    var radius: CGFloat
    var lastRotation: CGFloat
    
    required init(origin: CGPoint, color: UIColor){
        self.path = UIBezierPath()
        self.radius = 50
        self.lastRotation = 0
        super.init(origin: origin, color: color)
    }
    
    
    override func draw() {
        color.setFill()
        path.removeAllPoints()
        path.addArc(withCenter: origin, radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        path.rotate(by: lastRotation)
        path.fill()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
    
    
}
