//
//  Line.swift
//  HaoranSong-Lab3
//
//  Created by Haoran Song on 10/2/22.
//

import UIKit

class Line: Shape{
    
    var allPoints:[CGPoint]
    
    required init(origin: CGPoint, color: UIColor){
        self.allPoints = [origin]
        super.init(origin: origin, color: color)
    }
    
    
    override func draw() {
        guard let context = UIGraphicsGetCurrentContext() else
        { return }
        
        for (i,p) in allPoints.enumerated(){
            if(i==0){
                context.move(to: p)
            }else{
                context.addLine(to: p)
            }
        }
        context.setStrokeColor(color.cgColor)
        context.strokePath()
    }
    
    
}
