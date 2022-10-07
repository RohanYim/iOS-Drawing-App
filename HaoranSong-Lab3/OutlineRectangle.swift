//
//  OutlineRectangle.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/6/22.
//

import UIKit

class OutlineRectangle: OutlineShape{
    
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
        color.setStroke()
        let long = side
        let short = side-50
        path.removeAllPoints()
        path = UIBezierPath(rect: CGRect(x: origin.x-long/2, y: origin.y-short/2, width: long, height: short))
        path.rotate(by: lastRotation)
        let lengths:[CGFloat] = [8.0, 4.0, 16.0, 8.0]
        path.setLineDash(lengths, count: 4, phase: 12)
        path.stroke()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
}
