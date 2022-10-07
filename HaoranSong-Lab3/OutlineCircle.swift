//
//  OutlineCircle.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/6/22.
//

import UIKit

class OutlineCircle: OutlineShape{
    
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
        color.setStroke()
        path.removeAllPoints()
        path.addArc(withCenter: origin, radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        path.rotate(by: lastRotation)
        let lengths:[CGFloat] = [8.0, 4.0, 16.0, 8.0]
        path.setLineDash(lengths, count: 4, phase: 12)
        path.stroke()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
    
    
}
