//
//  Rectangle.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/1/22.
//

import UIKit

class Rectangle: Shape{
    
    var path:UIBezierPath
    var side:CGFloat
    var lastRotation: CGFloat
    
    required init(origin: CGPoint, color: UIColor){
        self.path = UIBezierPath()
        self.side = 120
        self.lastRotation = 0
        super.init(origin: origin, color: color)
    }
    
    
    override func draw() {
        color.setFill()
        let long = side
        let short = side-50
        path.removeAllPoints()
        path = UIBezierPath(rect: CGRect(x: origin.x-long/2, y: origin.y-short/2, width: long, height: short))
        path.rotate(by: lastRotation)
        path.fill()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
}
