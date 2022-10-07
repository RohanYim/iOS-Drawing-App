//
//  OutlineTriangle.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/6/22.
//

import UIKit

class OutlineTriangle: OutlineShape{
    
    var path:UIBezierPath
    var side: CGFloat
    var lastRotation: CGFloat
    
    required init(origin: CGPoint, color: UIColor){
        self.path = UIBezierPath()
        self.side = 100
        self.lastRotation = 0
        super.init(origin: origin, color: color)
    }
    
    
    override func draw() {
        color.setStroke()
        let startX = origin.x
        let startY = origin.y - sqrt(3)/4*side
        path.removeAllPoints()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: startX-side/2, y: startY+sqrt(3)/2*side))
        path.addLine(to: CGPoint(x: startX+side/2, y: startY+sqrt(3)/2*side))
        path.close()
        path.rotate(by: lastRotation)
        let lengths:[CGFloat] = [8.0, 4.0, 16.0, 8.0]
        path.setLineDash(lengths, count: 4, phase: 12)
        path.stroke()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
}
